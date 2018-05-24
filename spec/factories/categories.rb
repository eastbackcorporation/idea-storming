# frozen_string_literal: true

FactoryBot.define do
  factory :category, class: 'Category' do
    sequence(:title) { |n| "Title#{n}" }
    description 'Description'
  end
end
