require 'rails_helper'
require 'capybara/rspec'
RSpec.describe 'User flow', type: :feature do
  before(:each) do
    # Preparation for test
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
end
