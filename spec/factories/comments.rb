FactoryBot.define do
  factory :comment_auth_user, class: Comment do
    body { 'Super!' }

    association :event
    association :user
  end

  factory :comment_anon_user, class: Comment do
    user_name { 'Katie' }
    body { 'Super!' }

    association :event
  end
end
