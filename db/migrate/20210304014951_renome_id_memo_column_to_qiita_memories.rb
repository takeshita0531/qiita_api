class RenomeIdMemoColumnToQiitaMemories < ActiveRecord::Migration[5.0]
  def change
    rename_column :qiita_memories, :id_memo, :create_at_memo
  end
end
