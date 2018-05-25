# frozen_string_literal: true

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
