class AddIdMemoToQiitaMemories < ActiveRecord::Migration[5.0]
  def change
    add_column :qiita_memories, :id_memo, :string
  end
end
