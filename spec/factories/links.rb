FactoryBot.define do
  factory :link do
    long_url { Faker::Internet.url }
  end
end
