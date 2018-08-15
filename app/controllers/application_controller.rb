class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_any!

  def authenticate_any!
    if user_signed_in?
      true
    else
      authenticate_user!
    end
  end

  def current_usuario
    current_user
  end

  def admin_signed_in?
    current_user.admin?
  end

  def current_admin
    current_user if current_user.admin?
  end
end
