require 'rails_helper'
require 'capybara/rspec'
RSpec.describe 'User flow', type: :feature do
  before(:each) do
    # Priprema podataka za testiranje
  end
  describe 'User index page' do
    it 'displays the username of all other users' do
      visit users_path
      expect(page).to have_selector('.name_bio h2')
    end
    it 'displays the profile picture for each user' do
      visit users_path
      expect(page).to have_selector('.photo img')
    end
    it 'displays the number of posts each user has written' do
      visit root_path
      User.all.each do |_user|
        expect(page).to have_content('Number of posts')
      end
    end
    it 'redirects to the user show page when clicking on a user' do
      user = User.first
      visit users_path
      first(:link, user.name).click
      expect(current_path).to eq(user_path(user))
    end
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
