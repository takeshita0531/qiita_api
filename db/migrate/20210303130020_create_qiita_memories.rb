class CreateQiitaMemories < ActiveRecord::Migration[5.0]
  def change
    create_table :qiita_memories do |t|
      t.string :title_memo
      t.string :url_memo
      t.string :user_memo

      t.timestamps
    end
  end
end
