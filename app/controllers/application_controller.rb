# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_request_from
  before_action :store_user_location!, if: :storable_location?
  before_action :configure_permitted_parameters, if: :devise_controller?

  # 戻るボタン用に、元いたページをセットする。
  def set_request_from
    @request_from = session[stored_location_key_for(:user)]
  end

  protected

  # deviseによるユーザ項目
  def configure_permitted_parameters
    added_attrs = %i[nick_name email password password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    return admin_root_path if resource&.admin?
    stored_path = stored_location_for(resource)
    return dashboard_index_path if stored_path == root_path
    stored_path || super
  end

  # ログアウト後のリダイレクト先
  def after_sign_out_path_for(_resource)
    root_path
  end

  def sign_out_user
    return if current_user.blank?
    sign_out :admin_user if current_user&.admin?
  end

  private

  # Its important that the location is NOT stored if:
  # - The request method is not GET (non idempotent)
  # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an
  #    infinite redirect loop.
  # - The request is an Ajax request as this can lead to very unexpected behaviour.
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end
end
