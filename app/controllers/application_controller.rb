class ApplicationController < ActionController::Base
  #before_action :configure_authentication
  private

  def configure_authentication
    if params.present?
      admin = Admin.new(admin_params)
    end
    if admin_controller?
      #sign_in(admin)
      #authenticate_admin!
      #sign_in
    else
      authenticate_user! unless action_is_public?
    end
  end

  def admin_controller?
    self.class.module_parent_name == 'Admin'
  end

  def action_is_public?
    controller_name == 'homes' && action_name == 'top'
  end
  
  def admin_params
    #params.require(:admin).permit(:email, :password)
  end
end