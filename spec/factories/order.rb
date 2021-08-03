FactoryBot.define do
  factory :order do
    association :user
    amount { 30.99 }
  end
end
