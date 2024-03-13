class AddUserReferenceToGroup < ActiveRecord::Migration[6.1]
  def change
    change_table :groups do |t|
      t.references :user_adm, null: false, foreign_key: { to_table: :users }
    end
  end
end
