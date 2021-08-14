class CreateUserInvites < ActiveRecord::Migration[6.1]
  def change
    create_table :user_invites do |t|
      t.boolean :is_accepted
      t.timestamps
    end

    # inviter
    add_column :user_invites, :user_inviter_id, :integer
    add_foreign_key :user_invites, :users, column: :user_inviter_id

    # invitee
    add_column :user_invites, :user_invitee_id, :integer
    add_foreign_key :user_invites, :users, column: :user_invitee_id
  end
end
