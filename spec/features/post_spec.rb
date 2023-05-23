require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Posts', type: :system, js: true do
  describe 'index page' do
    before(:example) do
      @messi = User.create(name: 'Messi', photo: 'https://i.imgur.com/messi.jpg', bio: 'I love Barcelona and Argentina.')
      @cr7 = User.create(name: 'Cristiano', photo: 'https://i.imgur.com/cr7.jpg', bio: 'I am ubleivable inside the pitch.')

      @messi_post1 = Post.create(title: 'First Post', text: 'This is the first post.', author: @messi)
      @messi_post2 = Post.create(title: 'Second Post', text: 'This is the second post.', author: @messi)
      @messi_post3 = Post.create(title: 'Third Post', text: 'This is the third post.', author: @messi)
      @messi_post4 = Post.create(title: 'Fourth Post', text: 'This is the fourth post.', author: @messi)

      @comment2 = Comment.create(text: "I'm not feeling too good, G!.", author: @messi, post: @messi_post1)

      visit user_posts_path(@messi)
    end
    it 'should render post information' do
      @messi.posts.each do |post|
        expect(page).to have_content(post.title)
        expect(page).to have_content(post.text)
        expect(page).to have_content(post.comments_counter)
      end
    end
    it 'should render post interactions counts' do
      @messi.posts.each do |_post|
        expect(page).to have_content('Comments counter')
        expect(page).to have_content('Likes counter')
      end
    end
    it 'displays a message when there are no comments' do
      expect(page).to have_css('.comments', text: 'No comments yet!')
    end

    it 'displays an add comment button' do
      @messi.posts.each do |_post|
        expect(page).to have_link('Add new comment')
      end
    end
  end
end
