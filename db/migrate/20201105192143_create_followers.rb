class CreateFollowers < ActiveRecord::Migration[6.0]
  def change
    create_table :followers do |t|
      t.integer :follower_id, null: false
      t.integer :followed_id, null: false
      t.foreign_key :users, column: :follower_id, on_delete: :cascade
      t.foreign_key :users, column: :followed_id, on_delete: :cascade

      t.timestamps
    end

    add_index :users, :follower_id
    add_index :users, :followed_id
    add_index :followers, %i[follower_id followed_id], unique: true
  end
end
