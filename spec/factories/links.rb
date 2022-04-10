FactoryBot.define do
  factory :link do
    long_url { Faker::Internet.url }
    user     { build(:user) }
  end
end
