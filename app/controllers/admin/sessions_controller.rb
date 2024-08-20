# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  layout 'admin'
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    admin_dashboards_path # ログイン後にリダイレクトするパス
  end

  def after_sign_out_path_for(resource_or_scope)
    new_admin_session_path # ログアウト後にリダイレクトするパス
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
end