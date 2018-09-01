class Api::V1::BaseController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def verificar_veiculo
    puts "------BASIC AUTH-------"
    authenticate_with_http_basic do |token_veiculo, _password|
      puts "-------PROCURANDO VEÍCULO---------"
      @veiculo = Veiculo.find_by(token_integracao: token_veiculo)
    end
    raise 'Veiculo não encontrado' unless @veiculo
    @veiculo
  end

end
