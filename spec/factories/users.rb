FactoryBot.define do
  factory :user, :class => 'User' do
    name { Faker::Name.name }
    username { Faker::Name.first_name }
    email { Faker::Internet.email }
    password { "12345678" }

    trait :admin do
      admin { true }
    end
  end
end
