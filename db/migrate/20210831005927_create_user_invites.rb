class CreateUserInvites < ActiveRecord::Migration[6.1]
  def change
    create_table :user_invites do |t|
      t.boolean :is_accepted, default: false
      t.references :user_invite_id, null: false, foreign_key: { to_table: :users }
      t.references :user_invitee_id, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
