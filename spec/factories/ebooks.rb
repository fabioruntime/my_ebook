FactoryBot.define do
  factory :ebook do
    title { Faker::Book.title }
    description { Faker::Lorem.paragraphs(number: 1) }
    date_release { Date.today }
    price { 99.99 }
    num_pages { 50 }
  end
end
