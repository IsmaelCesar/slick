class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :nome
      t.string :group_image_url

      t.timestamps
    end
  end
end
