class AddFileIdtoFolders < ActiveRecord::Migration[5.0]
  def change 
    add_column :folders, :file_id, :integer
  end
end
