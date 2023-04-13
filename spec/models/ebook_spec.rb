require "rails_helper"

describe Ebook do
  let!(:ebook) { FactoryBot.create(:ebook) }
  let!(:user1) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user) }
  let!(:author1) { FactoryBot.create(:author) }
  let!(:author2) { FactoryBot.create(:author) }

  subject do
    described_class.new(
      title: Faker::Book.title,
      description: Faker::Lorem.paragraphs(number: 1),
      date_release: Date.today,
      price: 99.99,
      num_pages: 50,
    )
  end

  it "is valid with valid attributes" do
    expect(subject).to(be_valid)
  end

  it "is not valid without a title" do
    subject.title = nil
    expect(subject).not_to(be_valid)
  end

  it "is not valid without a description" do
    subject.description = nil
    expect(subject).not_to(be_valid)
  end

  it "is not valid with a unpermited description length" do
    subject.description = Faker::Lorem.characters(number: 10001)
    expect(subject).not_to(be_valid)
  end

  it "is not valid without a date release" do
    subject.date_release = nil
    expect(subject).not_to(be_valid)
  end

  it "is not valid without a price" do
    subject.price = nil
    expect(subject).not_to(be_valid)
  end

  it "is not valid without a price greater than zero" do
    subject.price = 0
    expect(subject).not_to(be_valid)
  end

  it "is not valid with unpermited price format" do
    subject.price = Float(0.001)
    expect(subject).not_to(be_valid)
    expect(subject.errors[:price]).to(include("Price must be greater than 0.01"))
  end

  it "is not valid with unpermited status" do
    expect { subject.status = 3 }
      .to(raise_error(ArgumentError)
      .with_message(a_string_including("is not a valid status")))
  end

  it "add authors to ebook" do
    ebook.authors << author1 << author2
    expect(ebook.authors.length).to(eql(2))
  end

  it "cannot add repeated authors to ebook" do
    ebook.authors << author1 << author1
    expect(ebook.authors.length).not_to(eql(2))
    expect(ebook.authors.length).to(eql(1))
  end

  it "add users to ebook" do
    ebook.users << user1 << user2
    expect(ebook.users.length).to(eql(2))
  end

  it "delete a ebook" do
    user1.ebooks << ebook
    user2.ebooks << ebook
    ebook.authors << author1 << author1

    expect(UserEbook.count).to(eql(2))
    expect(Author.count).to(eql(2))
    expect(User.count).to(eql(2))
    expect { ebook.destroy }.to change(Ebook, :count).by(-1)
    expect(UserEbook.count).to(eql(2))
    expect(Author.count).to(eql(2))
    expect(User.count).to(eql(2))
    expect(Ebook.count).to(eql(0))
  end
end
