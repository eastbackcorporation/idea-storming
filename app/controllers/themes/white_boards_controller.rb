class Themes::WhiteBoardsController < ApplicationController
  def create
    @theme = Theme.find_by(id: params[:theme_id])
    @theme.build_white_board if @theme.white_board.blank?
    @theme.white_board.assign_attributes(white_board_params)
    @theme.white_board.save
  end

  def update
    @theme = Theme.find_by(id: params[:theme_id])
    @theme.white_board.assign_attributes(white_board_params)
    @theme.white_board.save
  end

  private

  def white_board_params
    params.require(:white_board).permit(:content, :theme_id)
  end
end
