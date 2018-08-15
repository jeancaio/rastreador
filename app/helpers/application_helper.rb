module ApplicationHelper
  def current_admin
    current_user if current_user.admin?
  end
end
