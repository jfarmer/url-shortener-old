
RSpec.shared_examples 'the user created the requested link' do
  let(:default_template) { request.path_parameters['action'] }

  it 'assigns the requested link as @link' do
    get :edit, { short_name: link.to_param }, { user_id: link.user_id }
    expect(assigns(:link)).to eq(link)
  end

  it 'renders the default template' do
    get :edit, { short_name: link.to_param }, { user_id: link.user_id }
    expect(response).to render_template(default_template)
  end
end

RSpec.shared_examples 'the user did not create the requested link' do
  let(:default_template) { request.path_parameters['action'] }
  let(:other_user)       { FactoryGirl.create(:user) }

  it 'does not render the default template' do
    get :edit, { short_name: link.to_param }, { user_id: other_user.id }
    expect(response).to_not render_template(default_template)
  end

  it 'responds with a 403 Forbidden status code' do
    get :edit, { short_name: link.to_param }, { user_id: other_user.id }
    expect(response).to have_http_status(:forbidden)
  end
end

RSpec.shared_examples 'the user is not logged in' do
  let(:default_template) { request.path_parameters['action'] }

  it 'does not render the default template' do
    get :edit, { short_name: link.to_param }, {}
    expect(response).to_not render_template(default_template)
  end

  it 'responds with a 403 Forbidden status code' do
    get :edit, { short_name: link.to_param }, {}
    expect(response).to have_http_status(:forbidden)
  end
end
