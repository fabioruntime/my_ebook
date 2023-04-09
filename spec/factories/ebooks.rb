FactoryBot.define do
  factory :ebook do
    title { Faker::Company.name }
    description { Faker::Markdown.emphasis }
    date_release { Date.today }
    price { 99.99 }
    num_pages { 50 }
  end
end
