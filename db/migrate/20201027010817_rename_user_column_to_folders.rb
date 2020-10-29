class RenameUserColumnToFolders < ActiveRecord::Migration[5.0]
  def change
    rename_column :folders, :user, :user_name
  end
end
