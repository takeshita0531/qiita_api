class AddUserToFolders < ActiveRecord::Migration[5.0]
  def change
    add_column :folders, :title, :string
    add_column :folders, :url, :string
    add_column :folders, :user, :string
  end
end
