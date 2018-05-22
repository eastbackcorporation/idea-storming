FactoryBot.define do
  factory :user, class: "User" do
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:nick_name) { |n| "nick_name#{n}" }
    password "password"
    password_confirmation "password"
  end
end