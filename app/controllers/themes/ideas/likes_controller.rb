# frozen_string_literal: true

class Themes::Ideas::LikesController < ApplicationController
  # いいね登録
  # POST /themes/theme_id/ideas/idea_id
  def create
    @idea = Idea.find_by(id: params[:idea_id])
    @like = @idea.likes.build(user: current_user)
    @idea.save
  end

  # いいね削除
  # DELETE /themes/theme_id/ideas/idea_id/likes/id
  def destroy
    @idea = Idea.find_by(id: params[:idea_id])
    @idea.likes.where(user_id: current_user.id).destroy_all
  end
end
