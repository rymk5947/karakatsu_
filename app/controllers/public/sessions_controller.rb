class Public::SessionsController < Devise::SessionsController
  # before_action :user_state, only: [:create]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    posts_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to posts_path, notice: "ゲストユーザーでログインしました。"
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
end