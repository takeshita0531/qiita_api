class CreateMethodSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :method_searches do |t|
      t.string :method_name
      t.text :method_description
      t.string :method_url
      
      t.timestamps
    end
  end
end
