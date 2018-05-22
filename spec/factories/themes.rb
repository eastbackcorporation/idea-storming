FactoryBot.define do
  factory :theme, class: "Theme" do
    sequence(:title) { |n| "Title#{n}" }
    description "Description"
  end
end