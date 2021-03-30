class RemoveIdMemoFromQiitaMemories < ActiveRecord::Migration[5.0]
  def change
    remove_column :qiita_memories, :id_memo, :integer
  end
end
