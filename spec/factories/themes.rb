# frozen_string_literal: true

# == Schema Information
#
# Table name: themes
#
#  id            :bigint(8)        not null, primary key
#  title         :string(255)      not null
#  description   :text(65535)
#  owner_id      :bigint(8)        not null
#  category_id   :bigint(8)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  main_image_id :bigint(8)
#

FactoryBot.define do
  factory :theme, class: 'Theme' do
    sequence(:title) { |n| "Title#{n}" }
    description 'Description'
  end
end
