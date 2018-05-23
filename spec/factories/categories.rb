FactoryBot.define do
  factory :category, class: "Category" do
    sequence(:title) { |n| "Title#{n}" }
    description "Description"
  end
end
