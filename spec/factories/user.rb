FactoryBot.define do
  factory :user do
    email { Faker::Internet.free_email }
    name { Faker::Name }
  end
end
