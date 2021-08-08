class AddUserContactToContact < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :user_contact_id, :integer
    add_foreign_key :contacts, :users, column: :user_contact_id
  end
end
