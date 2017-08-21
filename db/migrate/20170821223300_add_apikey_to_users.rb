class AddApikeyToUsers < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :api_key, :string
    add_index :users, :api_key
  end

  def down
    remove_index :users, :api_key
    remove_column :users, :api_key, :string
  end

end
