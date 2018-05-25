# frozen_string_literal: true

class Idea < ApplicationRecord
  has_ancestry

  belongs_to :creator, class_name: 'User'
  belongs_to :theme

  validates :title, presence: true
  validates :description, presence: true
end
