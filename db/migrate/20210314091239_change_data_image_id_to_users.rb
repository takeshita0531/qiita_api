class ChangeDataImageIdToUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :image_id, :binary
  end
end
