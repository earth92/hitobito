# encoding: utf-8

# == Schema Information
#
# Table name: mailing_lists

#  Copyright (c) 2021, Pfadibewegung Schweiz. This file is part of
#  hitobito and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito.

class MailingListSubscriptionsSerializer < ApplicationSerializer
  schema do
    json_api_properties

    map_properties :id,
               :mailing_list_id,
               :subscriber_type,
               :subscriber_id,
               :excluded,
               :related_role_types
  end
end
