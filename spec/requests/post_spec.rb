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
          
      end
    end
  end
  