require 'rails_helper'

describe EbooksController do
  include ActiveJob::TestHelper

  let!(:ebook) { FactoryBot.create :ebook }
  let!(:user) { FactoryBot.create :user }

  context 'update a ebook' do
    before :each do
      @update_params = {
        id: ebook.id,
        status: :live
      }
    end

    it 'change ebook status' do
      expect(ebook.status).to eq(:draft.to_s)

      patch :change_status, params: @update_params
      ebook.reload
      expect(ebook.status).to eq(:live.to_s)
    end

    it 'send users email' do
      expect(enqueued_jobs.size).to eq 0
      expect do
        patch :change_status, params: @update_params
      end.to have_enqueued_mail(UserMailer, :changestatus_email).once
      expect(enqueued_jobs.size).to eq 1
    end
  end

  it 'create a ebook with unpermited title length' do
    new_params = {
      ebook: {
        title: 'te',
        description: Faker::Markdown.emphasis,
        email: Faker::Internet.email,
        date_release: Date.today,
        price: 99.99,
        num_pages: 50
      }
    }

    expect do
      post :create, params: new_params
    end.to change(Ebook, :count).by(0)
    expect(response).not_to be_redirect
    expect(response).to have_http_status(422)
  end
end
