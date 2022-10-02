FactoryBot.define do
  factory :subscription_auth_user, class: Subscription do
    association :user
    association :event
  end

  factory :subscription_anon_user, class: Subscription do
    user_name { 'Katie' }
    user_email { 'katie@gmail.com' }

    association :event
  end
end
