# frozen_string_literal: true

FactoryBot.define do
  factory :external_user_group do
    name { 'Goku' }
    role { 'owner' }
    source_group_id { 'Group-420' }
    content_id { 87 }
    external_application_id { 4 }
    client_id { 85 }
  end
end
