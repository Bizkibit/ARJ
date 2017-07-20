class CreateUsers < ActiveRecord::Migration[5.1]
  def up
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.date :dob
      t.string :username
      t.string :picture
      t.text :bio
      t.boolean :is_admin, default: false
      t.string :password_digest

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
  end

  def down
    drop_table :users
  end
end
