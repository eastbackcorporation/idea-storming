# frozen_string_literal: true

class Themes::IdeasController < ApplicationController
  before_action :authenticate_user!

  # 新規アイディア
  # GET    /themes/new
  def new
    @theme = Theme.find(params[:theme_id])
    @parent_idea = Idea.find_by(id: params[:idea_id])
  end

  # アイディア登録
  # POST   /themes/:theme_id/ideas
  def create
    @theme = Theme.find(params[:theme_id])
    @idea = Idea.new(idea_params)
    @idea.theme = @theme
    @idea.parent = @theme.ideas.find(params[:parent_id]) if params[:parent_id].present?
    @idea.creator = current_user
    @idea.save

    # ウォッチしているユーザにメール通知
    @theme.watch_users.each do |user|
      next if user == current_user
      UserMailer.notify_register_idea(user, @theme).deliver_later
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def idea_params
    params.require(:idea).permit(:title, :description)
  end
end
