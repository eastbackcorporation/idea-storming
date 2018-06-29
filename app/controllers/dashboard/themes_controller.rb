# frozen_string_literal: true

#
# ダッシュボードの個別テーマ一覧のコントローラ
#
class Dashboard::ThemesController < ApplicationController
  before_action :authenticate_user!

  # 一覧
  # GET /dashboard/themes/
  def index
    case params[:type]&.to_s
    when 'owner_themes'
      @themes = Theme.is_owner(current_user).order(updated_at: :desc)
    when 'joining_themes'
      @themes = Theme.no_owner(current_user).is_idea_creator(current_user)
    when 'bookmark_category_themes'
      @themes = Theme.bookmark_category(current_user)
    end

    @themes = @themes.page(params[:page])
  end
end
