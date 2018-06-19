# frozen_string_literal: true

# == Schema Information
#
# Table name: category_types
#
#  id               :bigint(8)        not null, primary key
#  type_name        :string(255)      not null
#  name             :string(255)      not null
#  disp_order       :integer
#  category_type_id :bigint(8)
#

FactoryBot.define do
  factory :category_type, class: 'CategoryType' do
    sequence(:type_name) { |n| "type_#{n}" }
    sequence(:name) { |n| "name_#{n}" }
  end
end
