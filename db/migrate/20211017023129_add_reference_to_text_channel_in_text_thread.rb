class AddReferenceToTextChannelInTextThread < ActiveRecord::Migration[6.1]
  def change
    change_table :text_threads do |t|
      t.references :text_channel, foreign_key: true, on_delete: :cascade
    end
  end
end
