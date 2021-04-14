class RemoveCreateAtMemoFromQiitaMemories < ActiveRecord::Migration[5.0]
  def change
    remove_column :qiita_memories, :create_at_memo, :time
  end
end
