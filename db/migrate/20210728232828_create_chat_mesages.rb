class CreateChatMesages < ActiveRecord::Migration[6.1]
  def change
    create_table :chat_mesages do |t|
      t.references :message, null: false, foreign_key: true
      t.references :contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
