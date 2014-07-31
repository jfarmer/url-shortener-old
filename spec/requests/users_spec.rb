require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:valid_attributes)   { FactoryGirl.attributes_for(:user) }
  let(:user)               { FactoryGirl.create(:user, valid_attributes) }
  let(:user_session)       { { user_id: user.id } }
  let(:logged_out_session) { {} }

  describe 'POST /users' do
    it 'works! (now write some real specs)' do
      post '/users', { user: valid_attributes }, logged_out_session

      expect(response).to redirect_to(root_url)
      expect(response.status).to be(302)
    end
  end
end
