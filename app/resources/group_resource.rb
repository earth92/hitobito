# frozen_string_literal: true

#  Copyright (c) 2023, Schweizer Wanderwege. This file is part of
#  hitobito and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito.

class GroupResource < ApplicationResource
  with_options writable: false do
    attribute :name, :string
    attribute :short_name, :string
    attribute(:display_name, :string) { @object.display_name }
    attribute(:layer, :boolean) { @object.layer? }
    attribute :type, :string
    attribute :email, :string
    attribute :address, :string
    attribute :zip_code, :integer
    attribute :town, :string
    attribute :country, :string
    attribute :created_at, :datetime
    attribute :updated_at, :datetime
    attribute :deleted_at, :datetime
  end

  belongs_to :parent, resource: GroupResource, writable: false, foreign_key: :parent_id
  belongs_to :layer_group, resource: GroupResource, writable: false, foreign_key: :layer_group_id do
    assign do |_groups, _layer_groups|
      # We use the accessor from `NestedSet#layer_group` and there is no setter method,
      # so we skip this.
      # Note: this might lead to a performance penalty.
    end
  end

  def authorize_create(model)
    # Writing groups is disabled for now
    raise CanCan::AccessDenied
  end

  def authorize_update(model)
    # Writing groups is disabled for now
    raise CanCan::AccessDenied
  end

  def index_ability
    JsonApi::GroupAbility.new(current_ability)
  end
end
