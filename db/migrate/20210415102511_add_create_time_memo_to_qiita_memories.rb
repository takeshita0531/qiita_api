class AddCreateTimeMemoToQiitaMemories < ActiveRecord::Migration[5.0]
  def change
    add_column :qiita_memories, :create_time_memo, :datetime
  end
end
