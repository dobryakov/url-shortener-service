class CreateClicks < ActiveRecord::Migration[5.1]
  def change
    create_table :clicks do |t|
      t.integer :link_id, foreign_key: true
      t.integer :visitor_id, foreign_key: true
      t.text :clicked_url

      t.timestamps
    end
  end
end
