class CreateExternalUserGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :external_user_groups do |t|
      t.string :name
      t.string :role
      t.string :source_group_id
      t.integer :content_id
      t.string :client_id
      t.integer :external_application_id

      t.timestamps
    end
    add_index :external_user_groups, :client_id
  end
end
