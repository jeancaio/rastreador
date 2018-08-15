class Users::SessionsController < Devise::SessionsController
  layout 'login'

  # Apos concluir o login, direciona para home/show_home
  def after_sign_in_path_for(_resource)
    home_index_path
  end
end
