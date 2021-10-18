class RenameColumnChat < ActiveRecord::Migration[6.1]
  def change
    rename_column :friends, :chats_id, :chat_id
  end
end
