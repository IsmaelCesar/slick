class AddChatReferenceToFiends < ActiveRecord::Migration[6.1]
  def change
    change_table :friends do |t|
      t.references :chats, null: false
    end
  end
end
