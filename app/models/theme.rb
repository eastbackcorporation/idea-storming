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
  has_many :ideas, dependent: :destroy

  has_many :theme_tags, dependent: :destroy
  accepts_nested_attributes_for :theme_tags, allow_destroy: true
  has_many :tags, through: :theme_tags

  belongs_to :owner, class_name: 'User'
  belongs_to :category

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

  # タグを保存する。
  # @param [Array] tag_name(String)
  # @return [Boolean]
  def save_tags(posted_tags)
    current_tags = tags.pluck(:name) unless tags.nil?
    old_tags = current_tags - posted_tags
    new_tags = posted_tags - current_tags

    old_tags.each do |old_name|
      tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name|
      theme_tag = Tag.find_or_create_by(name: new_name)
      tags << theme_tag
    end

    true
  rescue StandardError => e
    errors.add(:tags, :invalid)
    logger.error e.backtrace
    false
  end
end
