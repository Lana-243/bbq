FactoryBot.define do
  factory :event do
    association :user
    title { "Fireworks" }
    address { "Moscow" }
    datetime { Time.now }
  end
end
