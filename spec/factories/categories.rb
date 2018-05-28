# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id          :bigint(8)        not null, primary key
#  title       :string(255)      not null
#  description :text(65535)
#  disp_order  :integer
#  ancestry    :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :category, class: 'Category' do
    sequence(:name) { |n| "Name#{n}" }
    description 'Description'
  end
end
