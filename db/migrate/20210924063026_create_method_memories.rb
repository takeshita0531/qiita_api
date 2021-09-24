class CreateMethodMemories < ActiveRecord::Migration[5.0]
  def change
    create_table :method_memories do |t|
      t.string :method
      t.string :extracted_method_name
      t.string :extracted_method_url
      t.string :extracted_method_class
      t.string :extracted_method_description
      t.string :expected_method_qiita
      t.string :expected_url_qiita
      t.string :expected_title_qiita
      t.string :expected_user_name
      t.string :extracted_method_name
      t.string :extracted_method_url
      t.string :extracted_method_class

      t.timestamps
    end
  end
end
