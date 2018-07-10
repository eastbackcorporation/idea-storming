# frozen_string_literal: true

#
# ダッシュボードコントローラ
#
class DashboardController < ApplicationController
  before_action :authenticate_user!

  DISPLAY_LIMIT = 5 # ダッシュボードで表示する数

  # ダッシュボード表示
  # GET /dashboard
  def index
    @owner_themes =
      Theme.is_owner(current_user).order(updated_at: :desc).limit(DISPLAY_LIMIT)
    @joining_themes =
      Theme.no_owner(current_user).is_idea_creator(current_user).order(updated_at: :desc).limit(DISPLAY_LIMIT)
    @bookmark_category_themes =
      Theme.bookmark_category(current_user).limit(DISPLAY_LIMIT)

    @watch_themes = current_user.watch_themes.limit(DISPLAY_LIMIT)
  end
end
