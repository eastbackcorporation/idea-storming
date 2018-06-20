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

class CategoryType < ApplicationRecord
  has_many :categories
end
