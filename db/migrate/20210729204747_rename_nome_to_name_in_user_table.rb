class RenameNomeToNameInUserTable < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :nome, :name
  end
end
