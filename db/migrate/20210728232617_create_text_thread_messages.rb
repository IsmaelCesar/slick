class CreateTextThreadMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :text_thread_messages do |t|
      t.references :text_thread, null: false, foreign_key: true
      t.references :message, null: false, foreign_key: true

      t.timestamps
    end
  end
end
