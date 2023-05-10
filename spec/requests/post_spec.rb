require 'rails_helper'

RSpec.describe 'Posts controller:', type: :request do
  describe 'GET' do
    describe '/posts/index' do
      before(:each) do
        @test_user = User.create(name: 'Jugoslav', photo: 'https://i.imgur.com/5.jpg', bio: 'I am a test user.', posts_counter: 0)
        get user_posts_path(user_id: @test_user.id)
      end

      it 'returns a success response' do
        expect(response).to have_http_status(200)
      end

      it('renders the index template') do
        expect(response).to render_template(:index)
      end

      it('includes the placeholder text') do
        expect(response.body).to include('<h1>Posts</h1>')
        expect(response.body).to include('<title>BlogAppRails</title>')
        expect(response.body).to include('This is my first post')
      end
    end

    describe '/posts/show' do
      before(:each) do
        @user = User.create(name: 'Jugoslav', photo: 'https://i.imgur.com/5.jpg', bio: 'I am a test user.', posts_counter: 0)
        @post = Post.create(author: @user, title: 'my post', text: 'this is my test post', likes_counter: 0,
                            comments_counter: 0)

        get post_path(@post)
      end

      it('returns a success response') do
        expect(response).to have_http_status(200)
      end
      it('renders the show template') do
        expect(response).to render_template(:show)
      end
      it 'includes the placeholder text' do
        expect(response.body).to include('this is my test post')
      end
    end
  end
end
