# frozen_string_literal: true

class Settings::ProfilesController < ApplicationController
  before_action :authenticate_user!
  def edit; end

  def update
    if current_user.update(user_params)
      current_user.avatar.purge if params[:user][:destroy_avatar].present?
      redirect_to root_path, notice: t('.success')
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:nick_name, :avatar)
  end
end
