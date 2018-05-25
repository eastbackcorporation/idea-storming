# frozen_string_literal: true

# == Schema Information
#
# Table name: ideas
#
#  id          :bigint(8)        not null, primary key
#  theme_id    :bigint(8)
#  ancestry    :text(65535)
#  creator_id  :bigint(8)        not null
#  title       :string(255)      not null
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Idea < ApplicationRecord
  has_ancestry

  belongs_to :creator, class_name: 'User'
  belongs_to :theme

  validates :title, presence: true
  validates :description, presence: true
end
