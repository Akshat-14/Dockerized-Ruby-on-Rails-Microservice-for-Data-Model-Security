# frozen_string_literal: true

class ExternalUserGroup < ApplicationRecord
  validates_uniqueness_of :client_id
  validates :role, :name, presence: true
  validates :role, inclusion: { in: %w[owner collaborator consumer], message: '%{value} is not a valid role' }
end
