class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :genre
      t.text :message
      t.string :photo

      t.timestamps
    end
  end
end
