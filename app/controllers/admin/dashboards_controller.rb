class Admin::DashboardsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @user = User.all
  end
end
