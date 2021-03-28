class ChangeDataCreateAtMemoToQiitaMemories < ActiveRecord::Migration[5.0]
  def change
    change_column :qiita_memories, :create_at_memo, :datetime
  end
end
