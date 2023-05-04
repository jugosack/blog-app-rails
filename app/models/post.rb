class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :likes
  has_many :comments
  after_save :update_posts_counter
  def update_posts_counter
    author.increment!(:posts_counter)
  end
  
  def recent_comment
    comments.order(created_at: :desc).limit(5)
  end
  
end
