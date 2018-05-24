# frozen_string_literal: true

class Theme < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :category

  validates :title, presence: true
  validates :category, presence: true

  def owner?(user)
    owner == user
  end
end
