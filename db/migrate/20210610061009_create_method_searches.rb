class CreateMethodSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :method_searches do |t|

      t.timestamps
    end
  end
end
