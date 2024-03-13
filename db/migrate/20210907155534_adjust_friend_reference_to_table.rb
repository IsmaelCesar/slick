class AdjustFriendReferenceToTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :friends, :friend_id
    remove_column :friends, :Friend
    add_column :friends, :friend_id, :integer, null: false
    add_foreign_key :friends, :users, column: :friend_id
  end
end
