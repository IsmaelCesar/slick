class CreateTextChannelMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :text_channel_messages do |t|
      t.references :text_channel, null: false, foreign_key: true
      t.references :message, null: false, foreign_key: true

      t.timestamps
    end
  end
end
