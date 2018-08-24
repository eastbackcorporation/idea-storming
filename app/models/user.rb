# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  nick_name              :string(255)      not null
#  email                  :string(255)      not null
#  encrypted_password     :string(255)      not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  is_admin               :boolean          default(FALSE), not null
#  avatar_color           :integer          default("blue")
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :idea_likes, dependent: :destroy
  accepts_nested_attributes_for :idea_likes, allow_destroy: true
  has_many :like_ideas, class_name: 'Idea', through: :idea_likes, source: 'idea'

  has_many :category_bookmarks, dependent: :destroy
  has_many :categories, through: :category_bookmarks
  accepts_nested_attributes_for :category_bookmarks, allow_destroy: true

  has_many :watches, dependent: :destroy, class_name: 'ThemeWatch'
  has_many :watch_themes, through: :watches, class_name: 'Theme', source: 'theme'
  accepts_nested_attributes_for :watches, allow_destroy: true

  validates :email, presence: true
  validates :nick_name, presence: true

  scope :general_users, lambda {
    where(is_admin: false)
  }

  # プロフィール画像
  has_one_attached :avatar

  # プロフィール画像未設定時のプロフィール色
  enum avatar_color:  {
    blue: 0,
    green: 1,
    red: 2,
    pink: 3,
    purple: 4,
    orange: 5,
    black: 6,
    brown: 7
  }

  before_create do
    self.avatar_color = (0...self.class.avatar_colors.count).to_a.sample
  end

  def admin?
    is_admin?
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def avatar_char
    nick_name.strip[0].upcase
  end
end
