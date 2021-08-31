class CreateUserInvites < ActiveRecord::Migration[6.1]
  def change
    create_table :user_invites do |t|
      t.references :inviter, null: false, foreign_key: true
      t.references :invitee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
