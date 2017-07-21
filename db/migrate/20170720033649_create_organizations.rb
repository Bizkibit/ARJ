class CreateOrganizations < ActiveRecord::Migration[5.1]
  def up
    create_table :organizations do |t|
      t.string :name
      t.string :website
      t.string :phone
      t.string :address
      t.float :longitude
      t.float :latitude
      t.text :additional
      t.string :pictures
      t.string :aasm_state
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end

  def down
    drop_table :organizations
  end
end
