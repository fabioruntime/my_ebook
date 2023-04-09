require "rails_helper"

describe SessionsController do
  let(:user) { FactoryBot.create :user, :admin}

  it 'should be ok ' do
    login_params = {
      session: {
        email: user.email,
        password: user.password
      }
    }
    post :create, params: login_params
    expect(response).to be_redirect
    expect(response).to redirect_to user
    expect(response.status).to eq 302 #redirect
    expect(request.session[:user_id]).to eq user.id
  end

  it 'should fail without credentials' do
    login_params = {
      session: {
        email: '',
        password: ''
      }
    }

    post :create, params: login_params
    expect(response).not_to be_redirect
    expect(response.status).not_to eq 302
  end
end
