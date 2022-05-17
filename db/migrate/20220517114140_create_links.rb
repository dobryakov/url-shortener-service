class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.text :name
      t.text :slug
      t.text :url
      t.integer :clicks_count, default: 0

      t.timestamps
    end
  end
end
