class Api::V1::BaseController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def verificar_cliente
    authenticate_with_http_basic do |token_cliente, _password|
      @cliente = User.find_by(token_integracao: token_cliente)
    end
    raise 'Cliente não encontrado' unless @cliente
    @cliente
  end

end
