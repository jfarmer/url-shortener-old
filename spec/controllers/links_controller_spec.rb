require "rails_helper"

RSpec.describe LinksController, type: :controller do
  let(:valid_attributes)   { FactoryGirl.attributes_for(:link) }
  let(:invalid_attributes) { { :short_name => "waffles" } }
  let(:logged_out_session) { {} }
  let(:referrer)           { 'the-http-referrer' }

  before(:each) do
    request.env['HTTP_REFERER'] = referrer
  end

  describe "GET index" do
    it "assigns all links as @links in descending order" do
      link1 = Link.create! valid_attributes
      link2 = Link.create! valid_attributes
      get :index, {}, logged_out_session
      expect(assigns(:links)).to eq([link2, link1])
    end
  end

  describe "GET show" do
    it "redirects to the link's URL" do
      link = Link.create! valid_attributes
      get :show, { :short_name => link.to_param }, logged_out_session

      expect(response).to redirect_to(link.url)
    end

    it "increments the link's click count" do
      link = Link.create! valid_attributes

      expect {
        get :show, { :short_name => link.to_param }, logged_out_session
      }.to change { link.reload.clicks_count }.by(1)
    end
  end

  describe "GET new" do
    it "assigns a new link as @link" do
      get :new, {}, logged_out_session
      expect(assigns(:link)).to be_a_new(Link)
    end
  end

  describe 'GET edit' do
    let(:link) { FactoryGirl.create(:link_with_user) }

    behavior_when 'the user created the requested link'
    behavior_when 'the user did not create the requested link'
    behavior_when 'the user is not logged in'
  end

  describe 'PUT update' do
    let!(:link) { FactoryGirl.create(:link_with_user) }

    behavior_when "the user created the requested link" do
      it 'destroys the requested link' do
        expect {
          delete :destroy, {:short_name => link.to_param}, { user_id: link.user_id }
        }.to change(Link, :count).by(-1)
      end

      it 'redirects to the referrer' do
        delete :destroy, {:short_name => link.to_param}, { user_id: link.user_id }
        expect(response).to redirect_to(referrer)
      end
    end

    behavior_when "the user did not create the requested link" do
      it 'does not destroy the requested link' do
        expect {
          delete :destroy, {:short_name => link.to_param}, { user_id: other_user.id }
        }.to_not change(Link, :count)
      end
    end

    behavior_when "the user is not logged in" do
      it 'does not destroy the requested link' do
        expect {
          delete :destroy, {:short_name => link.to_param}, {}
        }.to_not change(Link, :count)
      end
    end
  end


  describe 'DELETE destroy' do
    let!(:link) { FactoryGirl.create(:link_with_user) }

    behavior_when "the user created the requested link" do
      it 'destroys the requested link' do
        expect {
          delete :destroy, {:short_name => link.to_param}, { user_id: link.user_id }
        }.to change(Link, :count).by(-1)
      end

      it 'redirects to the referrer' do
        delete :destroy, {:short_name => link.to_param}, { user_id: link.user_id }
        expect(response).to redirect_to(referrer)
      end
    end

    behavior_when "the user did not create the requested link" do
      it 'does not destroy the requested link' do
        expect {
          delete :destroy, {:short_name => link.to_param}, { user_id: other_user.id }
        }.to_not change(Link, :count)
      end
    end

    behavior_when "the user is not logged in" do
      it 'does not destroy the requested link' do
        expect {
          delete :destroy, {:short_name => link.to_param}, {}
        }.to_not change(Link, :count)
      end
    end
  end

  describe "POST create" do
    context "when logged in" do
      let(:user) { FactoryGirl.create(:user) }

      it "assigns the newly created link to the current user" do
        post :create, { :link => valid_attributes }, user_id: user.id
        expect(assigns(:link).user).to eq(user)
      end
    end

    context "with valid params" do
      it "creates a new Link" do
        expect {
          post :create, { :link => valid_attributes }, logged_out_session
        }.to change(Link, :count).by(1)
      end

      it "assigns a newly created link as @link" do
        post :create, { :link => valid_attributes }, logged_out_session
        expect(assigns(:link)).to be_a(Link)
        expect(assigns(:link)).to be_persisted
      end

      it "redirects to the root URL" do
        post :create, { :link => valid_attributes }, logged_out_session
        expect(response).to redirect_to(root_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved link as @link" do
        post :create, { :link => invalid_attributes }, logged_out_session
        expect(assigns(:link)).to be_a_new(Link)
      end

      it "re-renders the 'new' template" do
        post :create, { :link => invalid_attributes }, logged_out_session
        expect(response).to render_template("new")
      end
    end
  end
end
