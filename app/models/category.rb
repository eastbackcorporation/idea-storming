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
#

class Category < ApplicationRecord
  has_ancestry
  has_many :themes
  belongs_to :category_type
  belongs_to :categories, optional: true

  has_many :category_bookmarks, dependent: :destroy
  has_many :bookmark_users, through: :category_bookmarks, source: :user

  validates :name, uniqueness: true
end
