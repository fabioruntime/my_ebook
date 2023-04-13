require 'rails_helper'

describe UsersController do
  let!(:user) { FactoryBot.create :user, :admin }
  let!(:user2) { FactoryBot.create :user }

  context 'update a user with admin role' do
    before :each do
      login(user)
    end

    it 'change user status' do
      update_params = {
        id: user.id,
        status: :enable
      }

      expect(user.status).to eq(:disable.to_s)

      patch :change_status, params: update_params

      user.reload
      expect(user.status).to eq(:enable.to_s)
    end

    it 'try update a user with user logged' do
      update_params = {
        id: user.id,
        user: {
          name: "#{user.name}_test"
        }
      }

      patch :update, params: update_params
      expect(response).to be_redirect
      expect(User.find_by_name("#{user.name}_test")).to eq(user)
    end

    it 'try update a user with user not owner, with admin role' do
      login(user)

      update_params = {
        id: user2.id,
        user: {
          name: "#{user2.name}_test"
        }
      }

      patch :update, params: update_params
      expect(User.find_by_name("#{user2.name}_test")).to eq(user2)
    end

    it 'updates a users password with unpermited password length' do
      update_params = {
        id: user.id,
        user: {
          password: Faker::Lorem.characters(number: 4)
        }
      }

      patch :update, params: update_params
      expect(response).to have_http_status(422) # HTTP Status 422 Unprocessable entity
      expect(user).to be_valid
    end
  end

  it 'try update a user with user not owner without admin role' do
    login(user2)

    update_params = {
      id: user.id,
      user: {
        name: "#{user.name}_test"
      }
    }

    patch :update, params: update_params
    expect(user.name).not_to eql("#{user.name}_test")
  end

  it 'create a user with unpermited username length' do
    new_user = {
      user: {
        name: Faker::Name.name,
        username: Faker::Lorem.characters(number: 2),
        email: Faker::Internet.email,
        password: Faker::Lorem.characters(number: 8)
      }
    }

    expect do
      post :create, params: new_user
    end.to change(User, :count).by(0)
    expect(response).not_to be_redirect
    expect(response).to have_http_status(422)
  end
end
