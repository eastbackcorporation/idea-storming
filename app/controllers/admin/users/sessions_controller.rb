# frozen_string_literal: true

class Admin::Users::SessionsController < Devise::SessionsController
  before_action :sign_out_user, only: %i[new create]
  before_action :validate_role!, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #  super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  # ログイン画面のロール毎に正しいユーザであるか事前チェック
  def validate_role!
    resource = User.find_by(email: params['admin_user']['email'])
    unless resource&.admin?
      sign_out :admin_user
      redirect_to new_admin_user_session_path, notice: t('.not_admin')
      return
    end
  end
end
