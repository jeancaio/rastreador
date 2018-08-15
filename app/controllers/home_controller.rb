class HomeController < ApplicationController
  def index
    if admin_signed_in?
      redirect_to admin_home_admin_index_path
    else
      if user_signed_in?
        redirect_to home_home_index_path
      end
    end
  end

end
