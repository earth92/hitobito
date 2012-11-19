# encoding: utf-8

class GroupDecorator < ApplicationDecorator
  decorates :group

  include ContactableDecorator

  class GroupedChildrenHelper

  end

  def possible_children_links
    model.class.possible_children.map do |type|
      link = h.new_group_path(group: { parent_id: self.id, type: type.sti_name})
      h.link_to(type.model_name.human, link)
    end
  end

  def possible_role_links
    possible_roles.map do |entry|
      link = h.new_group_role_path(self, role: { type: entry[:sti_name]})
      h.link_to(entry[:human], link)
    end
  end

  def possible_roles
    model.class.role_types.map do |type|
      if !type.restricted &&
        (type.visible_from_above? || can?(:index_local_people, model))  # users from above cannot create external roles
        { sti_name: type.sti_name, human: type.model_name.human } 
      end
    end.compact
  end


  ### EVENT
  def possible_events
    model.class.event_types
  end

  def event_link(et)
    h.new_group_event_path(event: {type: et.sti_name})
  end

  def new_event_button
    e = possible_events.first
    h.action_button("#{e.model_name.human} hinzufügen", event_link(e), :plus)
  end

  def new_event_dropdown
    h.dropdown_button('Event hinzufügen', possible_event_links, :plus)
  end

  def possible_event_links
    possible_events.map do |type|
      h.link_to(type.model_name.human, event_link(type))
    end
  end

  def new_event_dropdown_button
    if can?(:new, group.new_event)
      possible_events.count == 1 ? new_event_button : new_event_dropdown
    end
  end
  
  def bottom?
    klass.possible_children.none?(&:layer)
  end

  
  def people_filter_links
    links = []
    links << h.link_to('Mitglieder', h.group_people_path(model))
    if can?(:index_local_people, model)
      links << h.link_to('Externe', 
                         h.group_people_path(model, 
                                             role_types: Role.external_types.collect(&:sti_name), 
                                             name: 'Externe'))
    end
    
    if layer?
      filters = PeopleFilter.for_group(model)
      if filters.present?
        links << nil
        filters.collect { |filter| links << people_filter_link(filter) }
      end
      
      if can?(:new, model.people_filters.new)
        links << nil
        links << h.link_to('Neuer Filter...', 
                           h.new_group_people_filter_path(id, people_filter: h.params.slice(:kind, :role_types)))
      end
    end
    links
  end
  
  def people_filter_link(filter)
     link = h.group_people_path(kind: filter.kind, role_types: filter.role_types.collect(&:to_s), name: filter.name)
     html = h.link_to(filter.name, link)

     if can?(:destroy, filter)
       { html => [h.link_action_destroy(h.group_people_filter_path(model, filter))] }
     else
       html
     end
  end
  
  def filter_name
    h.params[:name] || (h.params[:role_types] ? 'Eigener Filter' : 'Mitglieder')
  end
  
  def modifiable_attributes(*attributes)
    attributes = used_attributes(*attributes)
    attributes -= model.class.superior_attributes unless can?(:modify_superior, model)
    attributes
  end


  def grouped_children
    @grouped_children ||= GroupListDecorator.new(model)
  end


  def type_name
    klass.model_name.human
  end

end
