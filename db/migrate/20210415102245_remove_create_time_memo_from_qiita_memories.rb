class RemoveCreateTimeMemoFromQiitaMemories < ActiveRecord::Migration[5.0]
  def change
    remove_column :qiita_memories, :create_time_memo, :datetime
  end
end
