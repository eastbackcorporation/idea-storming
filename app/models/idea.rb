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

  has_many :likes, class_name: 'IdeaLike', foreign_key: :idea_id, dependent: :destroy
  accepts_nested_attributes_for :likes, allow_destroy: true
  has_many :like_users, class_name: 'User', through: :likes, source: :user

  belongs_to :creator, class_name: 'User'
  belongs_to :theme, touch: true

  validates :title, presence: true
  validates :description, presence: true

  def like_from(user)
    likes.find_by(user_id: user&.id)
  end
end
