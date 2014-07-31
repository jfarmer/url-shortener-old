require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes)   { FactoryGirl.attributes_for(:user) }
  let(:invalid_attributes) { { email: '', password: '', password_cofirmation: '' } }
  let(:logged_out_session) { {} }

  describe 'GET new' do
    it 'assigns a new user as @user' do
      get :new, {}, {}
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'POST create' do
    context 'when logged in' do
      let(:user) { FactoryGirl.create(:user) }

      it 'does not assign anything to @user' do
        post :create, { user: valid_attributes }, user_id: user.id
        expect(assigns(:user)).to eq(nil)
      end

      it 'redirects to the root URL' do
        post :create, { user: valid_attributes }, user_id: user.id
        expect(response).to redirect_to(root_url)
      end
    end

    context 'with valid params' do
      it 'creates a new User' do
        expect do
          post :create, { user: valid_attributes }, logged_out_session
        end.to change(User, :count).by(1)
      end

      it 'assigns a newly created user as @user' do
        post :create, { user: valid_attributes }, logged_out_session
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it 'logs the user in' do
        expect(controller).to receive(:login!).with(User)
        post :create, { user: valid_attributes }, logged_out_session
      end

      it 'redirects to the root URL' do
        post :create, { user: valid_attributes }, logged_out_session
        expect(response).to redirect_to(root_url)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved user as @user' do
        post :create, { user: invalid_attributes }, logged_out_session
        expect(assigns(:user)).to be_a_new(User)
      end

      it 'does not log the user in' do
        expect(controller).to_not receive(:login!)
        post :create, { user: invalid_attributes }, logged_out_session
      end

      it "re-renders the 'new' template" do
        post :create, { user: invalid_attributes }, logged_out_session
        expect(response).to render_template('new')
      end
    end
  end
end
