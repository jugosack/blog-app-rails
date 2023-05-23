require 'rails_helper'
require 'capybara/rspec'
RSpec.describe 'User flow', type: :feature do
  before(:each) do
    # Preparation for test
  end
  describe 'User show page' do
    let(:user) { User.first }
    before(:each) do
      visit user_path(user)
    end
    it 'displays the user\'s profile picture' do
      expect(page).to have_selector('.photo img')
    end
    it 'displays the user\'s username' do
      expect(page).to have_content(user.name)
    end
    it 'displays the number of posts the user has written' do
      expect(page).to have_content("Number of posts(#{user.posts.count})")
    end
    it 'displays the user\'s bio' do
      expect(page).to have_content(user.bio)
    end
    it 'displays the user\'s first 3 posts' do
      posts = user.posts.last(3)
      posts.each do |post|
        expect(page).to have_content(post.title)
      end
    end
    it 'redirects to the user posts index page when clicking "See all posts"' do
      click_link 'See all posts'
      expect(current_path).to eq(user_posts_path(user))
    end
  end
end
