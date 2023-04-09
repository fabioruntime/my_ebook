require "rails_helper"

describe CheckoutController do
  include ActiveJob::TestHelper
  let!(:ebook) { FactoryBot.create :ebook }
  let!(:user) { FactoryBot.create :user}

  it 'add a new ebook to user' do
    login(user)

    params = {
      ebook_id: ebook.id
    }

    expect(current_user.ebooks.length).to eq(0)
    post :create, params: params
    expect(current_user.ebooks.length).to eq(1)
  end

  it 'add a new ebook to user' do

    params = {
      ebook_id: ebook.id
    }

    post :create, params: params
    expect(response).not_to be_redirect
    expect(current_user).to be_nil
  end

  it 'sends user emails' do
    login(user)
    params = {
      ebook_id: ebook.id
    }

    expect(enqueued_jobs.size).to eq 0
    expect {
      post :create, params: params
    }.to have_enqueued_mail(UserMailer, :confirmation_email).once
    expect(enqueued_jobs.size).to eq 1
  end
end
