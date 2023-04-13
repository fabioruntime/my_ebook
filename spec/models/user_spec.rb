require "rails_helper"

describe User do
  subject do
    described_class.new(
      name: Faker::Name.name,
      username: Faker::Name.first_name,
      email: Faker::Internet.email,
      password: Faker::Lorem.characters(number: 8),
    )
  end

  it "is valid with valid attributes" do
    expect(subject).to(be_valid)
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).not_to(be_valid)
  end

  it "is not valid without a username" do
    subject.username = nil
    expect(subject).not_to(be_valid)
  end

  it "is not valid with unpermited username length" do
    subject.username = Faker::Lorem.characters(number: 2)
    expect(subject).not_to(be_valid)
    expect(subject.errors[:username]).to(include("is too short (minimum is 3 characters)"))
  end

  it "is not valid without a email" do
    subject.email = nil
    expect(subject).not_to(be_valid)
  end

  it "is not valid without a valid email" do
    subject.email = "test.com"
    expect(subject).not_to(be_valid)
    expect(subject.errors[:email]).to(include("Incorrect email format"))
  end

  it "is not valid without a password" do
    subject.password = nil
    expect(subject).not_to(be_valid)
    expect(subject.errors[:password]).to(include("can't be blank"))
  end

  it "is not valid with unpermited password length" do
    subject.password = Faker::Lorem.characters(number: 4)
    expect(subject).not_to(be_valid)
    expect(subject.errors[:password]).to(include("is too short (minimum is 8 characters)"))
  end

  it "is not valid with unpermited status" do
    expect { subject.status = 2 }
      .to(raise_error(ArgumentError)
      .with_message(a_string_including("is not a valid status")))
  end

  it "add ebooks to user" do
    user = FactoryBot.create(:user)
    ebook1 = FactoryBot.create(:ebook)
    ebook2 = FactoryBot.create(:ebook)

    user.ebooks << ebook1 << ebook2
    expect(user.ebooks.length).to(eql(2))
  end
end
