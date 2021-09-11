class AddUserReferenceToGroup < ActiveRecord::Migration[6.1]
  def change
    change_table :groups do |t|
      t.references :user ,foreign_key: true
    end
  end
end
