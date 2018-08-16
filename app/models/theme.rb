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
  has_many_attached :images

  accepts_nested_attributes_for :images_attachments, allow_destroy: true

  has_many :ideas, dependent: :destroy

  has_many :theme_tags, dependent: :destroy
  accepts_nested_attributes_for :theme_tags, allow_destroy: true
  has_many :tags, through: :theme_tags

  has_many :watches, dependent: :destroy, class_name: 'ThemeWatch'
  accepts_nested_attributes_for :watches, allow_destroy: true
  has_many :watch_users, through: :watches, class_name: 'User', source: 'user'

  belongs_to :owner, class_name: 'User'
  belongs_to :category

  validates :title, presence: true
  validates :category, presence: true

  after_commit on: :create do
    # 登録カテゴリをブックマークしているユーザに通知する
    category.bookmark_users.each do |bookmark_user|
      next if owner == bookmark_user
      UserMailer.notify_register_theme(bookmark_user, self).deliver_later
    end
  end

  # userが作成者であるThemeを取得
  scope :is_owner, ->(user) { where(owner_id: user.id) }

  # userが作成者でないThemeを取得
  scope :no_owner, ->(user) { where.not(owner_id: user.id) }

  # userが関連Ideaの作成者であるか
  scope :is_idea_creator, ->(user) { where(id: Idea.where(creator_id: user.id).select(:theme_id)) }

  # userがブックマークしているカテゴリのテーマであるか
  scope :bookmark_category, ->(user) { where(category_id: user.categories) }

  # テーマのタイトル、内容、タグの部分一致による取得
  # @param [String] value
  scope :search_content, ->(value) do
    return Theme.all if value.blank?
    scope = Theme # .left_outer_joins(:tags)
    scope.where('title LIKE ?', "%#{value}%")
         .or(scope.where('description LIKE ?', "%#{value}%"))
         .or(scope.where(id: ThemeTag.where(tag_id: Tag.where('name LIKE ?', "%#{value}%")).select(:theme_id)))
  end

  # 指定されたカテゴリまたはそのカテゴリの下部階層のカテゴリに関連するテーマを取得する
  # @param [Integer] category_id
  scope :include_category, ->(category_id) do
    category = Category.find_by(id: category_id)
    where(category_id: category.descendant_ids.push(category_id))
  end

  # アイディア数の降順にsortする
  scope :order_ideas_count, -> do
    joins("LEFT OUTER JOIN(
             SELECT theme_id, count(id) AS count_ideas FROM ideas GROUP BY theme_id
           ) AS count_ideas_tb ON count_ideas_tb.theme_id = id")
      .order('count_ideas DESC')
  end

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

  # 引数で渡されたユーザのウォッチ
  # @param [User] user
  # @return [nil/ThemeWatch]
  def watch_from(user)
    watches.find_by(user_id: user&.id)
  end
end
