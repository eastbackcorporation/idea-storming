# frozen_string_literal: true

#
# ダッシュボードコントローラ
#
class DashboardController < ApplicationController
  before_action :authenticate_user!

  # ダッシュボード表示
  # GET /dashboard
  def index
    @owner_themes = Theme.is_owner(current_user).order(updated_at: :desc)
    @joining_themes = Theme.no_owner(current_user).is_idea_creator(current_user).order(updated_at: :desc)
  end
end
