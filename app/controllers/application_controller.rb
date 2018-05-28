# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # deviseによるユーザ項目
  def configure_permitted_parameters
    added_attrs = %i[nick_name email password password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end

  # ログイン後のリダイレクト先
  def after_sign_out_path_for(_resource)
    dashboard_index_path
  end
end
