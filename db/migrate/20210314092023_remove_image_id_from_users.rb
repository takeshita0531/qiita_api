class RemoveImageIdFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :image_id, :binary
  end
end
