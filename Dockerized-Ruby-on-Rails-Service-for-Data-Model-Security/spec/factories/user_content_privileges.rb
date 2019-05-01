# frozen_string_literal: true

FactoryBot.define do
  factory :user_content_privilege do
    role { 'consumer' }
    content_id { 123 }
    user_grouping_type { ' user' }
    user_grouping_id { 'Group-11' }
    client_id { Faker::Alphanumeric.alphanumeric 4 }
  end
end
