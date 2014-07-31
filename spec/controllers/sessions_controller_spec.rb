require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:email)             { 'test@example.com' }
  let(:password)          { 'qwerty123' }
  let(:valid_credentials) { { email: email, password: password } }

  let!(:user) { FactoryGirl.create(:user, valid_credentials) }

  before do
    request.env['HTTP_REFERER'] = 'the-best-website'
  end

  describe 'POST create' do
    context 'with valid credentials' do
      let(:credentials) { valid_credentials }

      it 'calls login! with given user' do
        expect(controller).to receive(:login!).with(user)
        post :create, { session: credentials }, {}
      end

      it 'redirects back to referrer' do
        post :create, { session: credentials }, {}
        expect(response).to redirect_to('the-best-website')
      end
    end

    context 'with invalid email' do
      let(:credentials) { { email: 'invalid.email@error.com', password: password } }

      it 'does not call login!' do
        expect(controller).to_not receive(:login!)
        post :create, { session: credentials }, {}
      end

      it 'redirects back to referrer' do
        post :create, { session: credentials }, {}
        expect(response).to redirect_to('the-best-website')
      end
    end

    context 'with invalid password' do
      let(:credentials) { { email: email, password: 'invalid-pass' } }

      it 'does not call login!' do
        expect(controller).to_not receive(:login!)
        post :create, { session: credentials }, {}
      end

      it 'redirects back to referrer' do
        post :create, { session: credentials }, {}
        expect(response).to redirect_to('the-best-website')
      end
    end
  end

  describe 'GET destroy' do
    context 'when user is logged in' do
      it 'logs the user out' do
        expect(controller).to receive(:logout!)
        get :destroy, {}, user_id: user.id
      end

      it 'redirects back to referrer' do
        get :destroy, {}, user_id: user.id
        expect(response).to redirect_to('the-best-website')
      end
    end

    context 'when the user is logged out' do
      it 'does not try to log the user out' do
        expect(controller).to_not receive(:logout)
        get :destroy, {}, {}
      end

      it 'redirects back to referrer' do
        get :destroy, {}, {}
        expect(response).to redirect_to('the-best-website')
      end
    end
  end
end
