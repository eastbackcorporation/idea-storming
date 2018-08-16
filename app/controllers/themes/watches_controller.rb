# frozen_string_literal: true

class Themes::WatchesController < ApplicationController
  def create
    @theme = Theme.find_by(id: params[:theme_id])
    @watch = @theme.watches.build(user: current_user)
    @theme.save
  end

  def destroy
    @theme = Theme.find_by(id: params[:theme_id])
    @theme.watches.where(user_id: current_user.id).destroy_all
  end
end
