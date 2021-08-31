class CreateTextThreads < ActiveRecord::Migration[6.1]
  def change
    create_table :text_threads do |t|
      t.references :text_channel_message, null: false, foreign_key: true
      t.string :label

      t.timestamps
    end
  end
end
