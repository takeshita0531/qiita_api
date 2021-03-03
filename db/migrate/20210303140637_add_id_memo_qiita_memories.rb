class AddIdMemoQiitaMemories < ActiveRecord::Migration[5.0]
  def change
    add_column :qiita_memories, :id_memo, :integer
  end
end
