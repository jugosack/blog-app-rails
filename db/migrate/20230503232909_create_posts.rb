class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.bigint :author_id
      t.text :title
      t.text :text
      t.integer :likes_counter
      t.integer :comments_counter

      t.timestamps
    end
  end
end
