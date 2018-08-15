class Users::RegistrationsController < Devise::RegistrationsController
  layout 'login'

  # POST /resource
  def create
    users_instancia = UsuarioInstancia.where(email: params[:user][:email])

    if users_instancia.count > 0

      build_resource(sign_up_params)
      resource.save
      yield resource if block_given?
      if resource.persisted?

        # Busca o user criado para salvar o token do aparelho celular que encontra-se no parametro da sessão
        user = Usuario.find_by(email: params[:user][:email])
        user.tokens_notificacao_mobile.create!(token: session[:token]) if session[:token]

        # Atribui a UsuarioInstanciaUsuario os users instancia e o proprio user.
        users_instancia.each do |usuario_instancia|
          UsuarioInstanciaUsuario.create!(usuario_instancia: usuario_instancia, user: user)
        end

        ConvidarUsuarioByEmailJob.perform_later(resource)

        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    else
      set_flash_message! :notice, :signed_up_invalid
      redirect_to new_usuario_registration_path
    end
end
