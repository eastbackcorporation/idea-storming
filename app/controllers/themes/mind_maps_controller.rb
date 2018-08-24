# frozen_string_literal: true

class Themes::MindMapsController < ApplicationController
  def create
    @theme = Theme.find_by(id: params[:theme_id])
    @theme.build_mind_map if @theme.mind_map.blank?
    @theme.mind_map.assign_attributes(mind_map_params)
    @theme.mind_map.save
  end

  def update
    @theme = Theme.find_by(id: params[:theme_id])
    @theme.mind_map.assign_attributes(mind_map_params)
    @theme.mind_map.save
  end

  private

  def mind_map_params
    params.require(:mind_map).permit(:content, :theme_id)
  end
end
