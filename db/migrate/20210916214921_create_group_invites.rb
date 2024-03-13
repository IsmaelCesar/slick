class CreateGroupInvites < ActiveRecord::Migration[6.1]
  def change
    create_table :group_invites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.boolean :is_accepted, default: false

      t.timestamps
    end
  end
end
