class ChangeDataArticleIdToFolders < ActiveRecord::Migration[5.0]
  def change
    change_column :folders, :article_id, :string
  end
end
