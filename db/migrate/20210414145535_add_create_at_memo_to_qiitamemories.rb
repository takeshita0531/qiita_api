class AddCreateAtMemoToQiitamemories < ActiveRecord::Migration[5.0]
  def change
    add_column :qiita_memories, :create_at_memo, :time
  end
end
