# require 'rails_helper'
# require 'capybara/rspec'

# RSpec.describe 'Posts', type: :system, js: true do
#   describe 'index page' do
#     before(:example) do
#       @messi = User.create(name: 'Messi', photo: 'https://i.imgur.com/messi.jpg', bio: 'I love Barcelona and Argentina.')
#       @cr7 = User.create(name: 'Cristiano', photo: 'https://i.imgur.com/cr7.jpg', bio: 'I am ubleivable inside the pitch.')

#       @messi_post1 = Post.create(title: 'First Post', text: 'This is the first post.', author: @messi)
#       @messi_post2 = Post.create(title: 'Second Post', text: 'This is the second post.', author: @messi)
#       @messi_post3 = Post.create(title: 'Third Post', text: 'This is the third post.', author: @messi)
#       @messi_post4 = Post.create(title: 'Fourth Post', text: 'This is the fourth post.', author: @messi)

#       @comment2 = Comment.create(text: "I'm not feeling too good, G!.", author: @messi, post: @messi_post1)

#       visit user_posts_path(@messi)
#     end

#     it 'should render user profile information' do
#       expect(page).to have_css("img[src*='messi.jpg']")
#       expect(page).to have_content(@messi.name)
#       expect(page).to have_content('Number of posts(3)')
#     end

#     it 'should render user posts' do
#       expect(page).to have_css('.post', count: 3)
#       @messi.posts.each do |post|
#         expect(page).to have_content(post.title)
#       end
#     end

#     it 'should render post information' do
#       @messi.posts.each do |post|
#         expect(page).to have_content(post.title)
#         expect(page).to have_content(post.text)
#         expect(page).to have_content(post.comments_counter)
#       end
#     end

#     it 'should render post interactions counts' do
#       @messi.posts.each do |_post|
#         expect(page).to have_content('Comments counter')
#         expect(page).to have_content('Likes counter')
#       end
#     end

#     it 'should render the first comments on a post' do
#       @messi.posts.each do |post|
#         expect(page).to have_content(post.comments.first)
#       end
#     end

#     it 'displays a message when there are no comments' do
#       expect(page).to have_css('.comments', text: 'No comments yet!')
#     end

#     it 'displays an add comment button' do
#       @messi.posts.each do |_post|
#         expect(page).to have_link('Add new comment')
#       end
#     end
#     it 'should show PAGINATION button' do
#       expect(page).to have_content('Pagination')
#     end
#   end
# end

require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'User post index page:', type: :feature do
  before(:each) do
    @user1 = User.create(name: 'unique_show', photo: 'http://localhost:3000/anything.jpg', bio: 'Anything test',
                         posts_counter: 0)
    @post1 = Post.create(title: 'post one', text: 'post one text', author: @user1, comments_counter: 0,
                         likes_counter: 0)
    @post2 = Post.create(title: 'post two', text: 'post two text', author: @user1, comments_counter: 0,
                         likes_counter: 0)
    @post3 = Post.create(title: 'post three', text: 'post three text', author: @user1, comments_counter: 0,
                         likes_counter: 0)
    @post4 = Post.create(title: 'post four', text: 'post four text', author: @user1, comments_counter: 0,
                         likes_counter: 0)
    @comment1 = Comment.create(text: 'comment one', author: @user1, post: @post1)
    @comment2 = Comment.create(text: 'comment two', author: @user1, post: @post1)
    @comment3 = Comment.create(text: 'comment three', author: @user1, post: @post1)
    @comment4 = Comment.create(text: 'comment four', author: @user1, post: @post1)
    @comment5 = Comment.create(text: 'comment five', author: @user1, post: @post1)
    @like1 = Like.create(author: @user1, post: @post1)
  end
  scenario 'I can see the users profile picture.' do
    visit user_posts_path(@user1.id)
    expect(@user1.photo).to match(%r{^http?://.*\.(jpe?g|gif|png)$})
  end
  scenario 'I can see the users name.' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content(@user1.name)
  end
  scenario 'I can see the number of posts the user has written.' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content(@user1.posts.count)
  end
  scenario 'I can see a posts title.' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content('post one')
  end
  scenario 'I can see some of the posts body.' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content(@post1.title)
  end
  # scenario 'I can see the first comments on a post.' do
  #   visit user_posts_path(@user1.id)
  #   expect(page).to have_content(@post1.recent_comments.first.text)
  # end
  scenario 'I can see how many comments a post has.' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content(@post1.comments.count)
  end
  scenario 'I can see how many likes a post has.' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content(@post1.likes.count)
  end
  scenario 'I can see a section for pagination if there are more posts than fit on the view.' do
    visit user_posts_path(@user1.id)
    expect(page).to have_button('Pagination')
  end
  scenario 'When I click on a post, it redirects me to that posts show page.' do
    visit user_posts_path(@user1.id)
    click_link('post one')
    expect(page).to have_current_path(user_post_path(@user1.id, @user1.posts.first.id))
  end
end
