class AddIndexToLike < ActiveRecord::Migration[7.0]
  def change
    add_index :likes, :author_id, name: 'index_likes_on_author_id'
    add_index :likes, :post_id, name: 'index_likes_on_post_id'
  end
end
