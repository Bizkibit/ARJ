class CreateEvents < ActiveRecord::Migration[5.1]
  def up
    create_table :events do |t|
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.time :end_time
      t.integer :spots
      t.text :details
      t.references :organization, foreign_key: true, index: true

      t.timestamps
    end
  end

  def down
    drop_table :events
  end
end
