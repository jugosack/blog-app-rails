require 'rails_helper'
require 'capybara/rspec'

RSpec.describe Like, type: :model do
  before(:all) do
    @user = User.create(
      name: 'Username',
      photo: 'https://i0.wp.com/imgs.hipertextual.com/wp-content/uploads/2022/10/Andor_Luthen-Rael.png',
      bio: 'myBio',
      posts_counter: 0
    )

    @post = Post.create(
      author: @user,
      title: 'My title',
      text: 'My blog with Rails',
      comments_counter: 0,
      likes_counter: 0
    )
  end

  context 'Like methods' do
    it 'update_likes_counter of post' do
      Like.create(author: @user, post: @post)
      expect(@post.likes_counter).to eq 1
    end
  end
end
