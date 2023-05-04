class Comment < ApplicationRecord
    belongs_to :author, class_name: 'User', foreign_key: 'author_id'
    belongs_to :post
    after_save :update_comment

    def update_comment
        post.increment!( :comments_counter)
    end
end