require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  controller do
    before_action :redirect_if_logged_in!, only: [:new]
    def index
      head :ok
    end

    def new
      head :ok
    end
  end

  describe '#current_user' do
    it 'returns nil when the session is empty' do
      get :index, {}, {}
      expect(controller.current_user).to eq(nil)
    end

    it "returns nil when the user doesn't exist" do
      get :index, {},  user_id: user.id + 100
      expect(controller.current_user).to eq(nil)
    end

    it 'returns the user specified in the session' do
      get :index, {},  user_id: user.id
      expect(controller.current_user).to eq(user)
    end
  end

  describe '#logged_in?' do
    it 'returns false when nobody is logged in' do
      get :index, {}, {}
      expect(controller.logged_in?).to eq(false)
    end

    it "returns false when the user doesn't exist" do
      get :index, {},  user_id: user.id + 100
      expect(controller.logged_in?).to eq(false)
    end

    it 'returns true when user_id is in the session' do
      get :index, {},  user_id: user.id
      expect(controller.logged_in?).to eq(true)
    end
  end

  describe '#login!' do
    it 'sets the current user' do
      expect do
        controller.login!(user)
      end.to change(controller, :current_user).from(nil).to(user)
    end

    it 'sets logged_in? to true' do
      expect do
        controller.login!(user)
      end.to change(controller, :logged_in?).from(false).to(true)
    end
  end

  describe '#logout!' do
    before do
      controller.login!(user)
    end

    it 'unsets the current user' do
      expect do
        controller.logout!
      end.to change(controller, :current_user).from(user).to(nil)
    end

    it 'sets logged_in? to true' do
      expect do
        controller.logout!
      end.to change(controller, :logged_in?).from(true).to(false)
    end

    it 'removes the user_id from the session' do
      expect do
        controller.logout!
      end.to change { controller.session[:user_id] }.from(user.id).to(nil)
    end
  end

  describe '#redirect_if_logged_in!' do
    context 'when the user is logged in' do
      it 'redirects to the root_url' do
        get :new, {},  user_id: user.id
        expect(response).to redirect_to(root_url)
      end
    end

    context 'when the user is logged out' do
      it 'does not redirect to the root url' do
        get :new, {}, {}
        expect(response.status).to eq(200)
      end
    end
  end
end
