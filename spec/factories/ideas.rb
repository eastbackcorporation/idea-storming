# frozen_string_literal: true

# == Schema Information
#
# Table name: ideas
#
#  id          :bigint(8)        not null, primary key
#  theme_id    :bigint(8)
#  ancestry    :text(65535)
#  creator_id  :bigint(8)        not null
#  title       :string(255)      not null
#  description :text(65535)
#  is_display  :boolean          default(TRUE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :idea do
    sequence(:title) { |n| "Idea Title #{n}" }
    sequence(:description) { |n| "Idea \nDescription  #{n}" }

    factory :idea_child do |f|
      f.parent FactoryBot.build(:idea)
    end
  end
end
