class AddAnsweredMessageToMessages < ActiveRecord::Migration[6.1]
  def change
    add_reference :messages, :answered_message, null: true, foreign_key: { to_table: :messages }, on_delete: :nullify
  end
end
