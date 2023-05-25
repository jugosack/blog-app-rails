class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post
  after_save :update_comment
  after_destroy :update_comment

  def update_comment
    post.update(comments_counter: post.comments.count)
  end
end
