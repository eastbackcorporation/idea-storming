# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id               :bigint(8)        not null, primary key
#  name             :string(255)      not null
#  description      :text(65535)
#  disp_order       :integer
#  ancestry         :string(255)
#  category_type_id :bigint(8)        not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  color            :string(255)      default("#d3d3d3")
#

FactoryBot.define do
  factory :category, class: 'Category' do
    sequence(:name) { |n| "Name#{n}" }
    description 'Description'
    association :category_type, factory: :category_type
  end
end
