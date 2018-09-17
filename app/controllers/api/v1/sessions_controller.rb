class Api::V1::SessionsController < Api::V1::BaseController
  def http_authenticate
    resource = User.find_by_email(params['email'])
    if resource.present?

      if resource.valid_password?(params['password'])
        if resource.confirmed?
          # Cria o token para notificação para o dispositivo do cliente
          # unless resource.tokens_notificacao_mobile.find_by(token: params[:token_notificacao])
          #   resource.tokens_notificacao_mobile.create!(token: params[:token_notificacao])
          # end
          sign_in :User, resource
          render json: { usuario: resource.email, token: resource.confirmation_token }, status: :ok
        else
          render json: { msg: 'Email não confirmado!' }, status: :unauthorized
        end
      else
        render json: { msg: 'Senha inválida!' }, status: :unauthorized
      end
    else
      render json: { msg: 'Email inválido!' }, status: :unauthorized
    end
  end
end
