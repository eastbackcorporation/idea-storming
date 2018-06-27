# frozen_string_literal: true

class UserMailer < ApplicationMailer
  # ブックマーク中のCategoryのテーマが登録された場合の通知
  def notify_regist_theme(user, theme)
    @user = user
    @theme = theme
    mail(to: user.email)
  end
end
