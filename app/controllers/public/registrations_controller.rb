class Public::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def after_sign_up_path_for(resource)
    posts_path
  end

  private
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :age, :sex, :introduction, :profile_image])
  end
end
