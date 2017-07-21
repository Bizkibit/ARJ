class CreateAttendances < ActiveRecord::Migration[5.1]
  def up
    create_table :attendances do |t|
      t.references :user, foreign_key: true, index: true
      t.references :event, foreign_key: true, index: true

      t.timestamps
    end
  end

  def down
    drop_table :attendances
  end
end
