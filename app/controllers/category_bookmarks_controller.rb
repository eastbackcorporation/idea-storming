# frozen_string_literal: true

#
# カテゴリブックマークコントローラ
#
class CategoryBookmarksController < ApplicationController
  before_action :authenticate_user!

  # GET /category_bookmarks
  def show
    @user = current_user
  end

  # PATCH /category_bookmarks
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to dashboard_index_path, notice: t('.success')
    else
      render :show
    end
  end

  private

  def user_params
    params.fetch(:user, {}).permit([category_ids: []])
  end
end
