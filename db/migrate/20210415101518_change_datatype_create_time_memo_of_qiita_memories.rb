class ChangeDatatypeCreateTimeMemoOfQiitaMemories < ActiveRecord::Migration[5.0]
  def change
    change_column :qiita_memories, :create_time_memo, :datetime
  end
end
