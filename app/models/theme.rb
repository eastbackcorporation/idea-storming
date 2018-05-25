# frozen_string_literal: true

# == Schema Information
#
# Table name: themes
#
#  id          :bigint(8)        not null, primary key
#  title       :string(255)      not null
#  description :text(65535)
#  owner_id    :bigint(8)        not null
#  category_id :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Theme < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :category
  has_many :ideas, dependent: :destroy

  validates :title, presence: true
  validates :category, presence: true

  # テーマの作成者であるか
  # @param [User] user
  # @return [True/False]
  def owner?(user)
    owner == user
  end
end
