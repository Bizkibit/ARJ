class CreateReviews < ActiveRecord::Migration[5.1]
  def up
    create_table :reviews do |t|
      t.text :body
      t.integer :rating
      t.references :organization, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end

  def down
    drop_table :reviews
  end
end
