# encoding: utf-8

#  Copyright (c) 2012-2017, Pfadibewegung Schweiz. This file is part of
#  hitobito_pbs and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_pbs.

class Event::ParticipationContactDatasController < ApplicationController
  include PrivacyPolicyAcceptable

  helper_method :group, :event, :entry

  authorize_resource :entry, class: Event::ParticipationContactData

  decorates :group, :event

  before_action :set_entry, :group, :policy_finder

  def edit; end

  def update
    if entry.valid? && privacy_policy_accepted? && entry.save
      set_privacy_policy_acceptance if privacy_policy_needed_and_accepted?

      redirect_to new_group_event_participation_path(
        group,
        event,
        event_role: { type: params[:event_role][:type] }
      )
    else
      add_privacy_policy_not_accepted_error(entry)
      render :edit
    end
  end

  private

  def entry
    @participation_contact_data
  end

  def build_entry
    Event::ParticipationContactData.new(event, current_user)
  end

  def set_entry
    @participation_contact_data =
      if params[:event_participation_contact_data]
        Event::ParticipationContactData.new(event, current_user, model_params)
      else
        build_entry
      end
  end

  def event
    @event ||= Event.find(params[:event_id])
  end

  def group
    @group ||= Group.find(params[:group_id])
  end

  def model_params
    params.require('event_participation_contact_data').permit(permitted_attrs)
  end

  def permitted_attrs
    PeopleController.permitted_attrs
  end

  def person
    @person ||= entry.person
  end

  def privacy_policy_param
    params[:event_participation_contact_data][:privacy_policy_accepted]
  end
end
