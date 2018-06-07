# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id         :bigint(8)        not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ApplicationRecord
  has_many :theme_tags, dependent: :destroy
  accepts_nested_attributes_for :theme_tags, allow_destroy: true
  has_many :themes, through: :theme_tags

  validates :name, uniqueness: true
end
