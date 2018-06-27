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

    @user.category_bookmarks.each do |category_bookmark|
      # パラメータにないcategory_bookmarkに削除フラグを立てる
      category_bookmark.mark_for_destruction unless category_bookmark.category_id.in? user_params_category_bookmarks_ids
    end

    if @user.update(user_params)
      redirect_to dashboard_index_path, notice: t('.success')
    else
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(
      category_bookmarks_attributes: %i[category_id]
    )
  end

  # パラメータを整形 (削除フラグ用)
  def user_params_category_bookmarks_ids
    return [] if user_params[:category_bookmarks_attributes].blank?
    user_params[:category_bookmarks_attributes].map { |p| p[:category_id] }.map(&:to_i)
  end
end
