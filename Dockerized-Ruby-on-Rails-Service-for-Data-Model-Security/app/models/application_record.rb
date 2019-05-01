# frozen_string_literal: true

# Inherits from ActiveRecord
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
