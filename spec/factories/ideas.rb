# frozen_string_literal: true

FactoryBot.define do
  factory :idea do
    sequence(:title) { |n| "Idea Title #{n}" }
    sequence(:description) { |n| "Idea \nDescription  #{n}" }

    factory :idea_child do |f|
      f.parent FactoryBot.build(:idea)
    end
  end
end
