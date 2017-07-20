class CreateApplications < ActiveRecord::Migration[5.1]
  def up
    create_table :applications do |t|
      t.references :user, foreign_key: true, index: true
      t.references :organization, foreign_key: true, index: true
      t.string :aasm_state
      t.text :detail

      t.timestamps
    end
  end

  def down
    drop_table :applications
  end
end
