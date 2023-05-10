require 'rails_helper'

RSpec.describe 'Users controller: ', type: :request do
  describe 'GET' do
    describe '/users/index' do
      it('returns a success response') do
        get users_path
        expect(response).to have_http_status(200)
      end
      it('renders the index template') do
        get users_path
        expect(response).to render_template(:index)
      end
    end
end
end