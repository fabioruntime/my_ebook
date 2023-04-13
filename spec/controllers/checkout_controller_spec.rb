require 'rails_helper'

describe CheckoutController do
  include ActiveJob::TestHelper
  let!(:ebook) { FactoryBot.create :ebook }
  let!(:user) { FactoryBot.create :user }

  before :each do
    @params = {
      ebook_id: ebook.id
    }
  end

  context 'user logged in' do
    before :each do
      login(user)
    end

    it 'add a new ebook to user' do
      expect(current_user.ebooks.length).to eq(0)
      post :create, params: @params
      expect(current_user.ebooks.length).to eq(1)
    end

    it 'sends user emails' do
      expect(enqueued_jobs.size).to eq 0
      expect do
        post :create, params: @params
      end.to have_enqueued_mail(UserMailer, :confirmation_email).once
      expect(enqueued_jobs.size).to eq 1
    end
  end

  it 'add new ebook to user not logged in' do
    post :create, params: @params
    expect(response).not_to be_redirect
    expect(current_user).to be_nil
  end
end
