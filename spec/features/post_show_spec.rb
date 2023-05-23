require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Posts', type: :system, js: true do
  describe 'post show page' do
    before(:example) do
      @messi = User.create(name: 'Messi', photo: 'https://i.imgur.com/messi.jpg', bio: 'I love Barcelona and Argentina.')
      @cr7 = User.create(name: 'Cristiano', photo: 'https://i.imgur.com/cr7.jpg', bio: 'I am ubleivable inside the pitch.')

      @messi_post = Post.create(title: 'First Post', text: 'This is the first post.', author: @messi)

      @comment2 = Comment.create(text: "I'm not feeling too good, G!.", author: @messi, post: @messi_post)

      visit user_post_path(@messi, @messi_post)
    end

    it "should show post's title" do
      expect(page).to have_content(@messi_post.title)
    end
    # it 'should show who wrote the post' do
    #   expect(page).to have_content("#{@messi_post.title} by #{@messi_post.author.name}")
    # end
    it 'should show how many comments it has' do
      expect(page).to have_content("Comments counter: #{@messi_post.comments_counter}")
    end
    it 'should show how many likes it has' do
      expect(page).to have_content('Likes counter: 0')
    end
    it 'should show the post body' do
      expect(page).to have_content(@messi_post.text)
    end
    it 'should show the username of each commentor' do
      @messi_post.comments.each do |comment|
        expect(page).to have_content(comment.author.name)
      end
    end
    it 'should show the comment each commentor left' do
      @messi_post.comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end
  end
end
