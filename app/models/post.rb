class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :likes
  has_many :comments
  after_save :update_posts_counter

  validates :title, presence: true, length: { maximum: 250 }
  validates :likes_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }
  validates :comments_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }

  def initialize(attributes = {})
    super
    self.comments_counter ||= 0
    self.likes_counter ||= 0
  end

  def update_posts_counter
    author.increment!(:posts_counter)
  end

  def recent_comment
    comments.order(created_at: :desc).limit(5)
  end
end
