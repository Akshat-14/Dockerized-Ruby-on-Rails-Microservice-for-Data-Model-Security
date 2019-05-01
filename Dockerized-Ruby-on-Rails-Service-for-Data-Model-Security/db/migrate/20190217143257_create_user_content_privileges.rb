# frozen_string_literal: true

# Inherits from ActiveRecord
class CreateUserContentPrivileges < ActiveRecord::Migration[5.2]
  def change
    create_table :user_content_privileges do |t|
      t.string :role
      t.integer :content_id
      t.string :user_grouping_type
      t.string :user_grouping_id
      t.string :client_id

      t.timestamps
    end
  end
end
