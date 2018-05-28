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

  # userが作成者であるThemeを取得
  scope :is_owner, ->(user) { where(owner_id: user.id) }

  # userが作成者でないThemeを取得
  scope :no_owner, ->(user) { where.not(owner_id: user.id) }

  # userが関連Ideaの作成者であるか
  scope :is_idea_creator, ->(user) { where(id: Idea.where(creator_id: user.id).select(:theme_id)) }

  # テーマの作成者であるか
  # @param [User] user
  # @return [True/False]
  def owner?(user)
    owner == user
  end
end
