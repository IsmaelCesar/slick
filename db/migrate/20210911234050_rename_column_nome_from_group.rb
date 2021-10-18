class RenameColumnNomeFromGroup < ActiveRecord::Migration[6.1]
  def change
    rename_column :groups, :nome, :name
  end
end
