class CreateChatMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :chat_messages do |t|
      t.references :message, null: false, foreign_key: true
      t.references :chat, null: false, foreign_key: true

      t.timestamps
    end
  end
end
