class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post
  after_save :update_likes

    def update_likes
        post.increment!(:likes_counter)
    end
end
