# frozen_string_literal: true

# Inherits from ApplicationRecord
class UserContentPrivilege < ApplicationRecord
  validates :client_id, presence: true
  validates_uniqueness_of :role, scope: %i[content_id user_grouping_type user_grouping_id], message: '=>content_id,user_grouping_id and user_grouping_type must be unique'
  validates :role, inclusion: { in: %w[owner collaborator consumer], message: '%{value} is not a valid role' }
end
