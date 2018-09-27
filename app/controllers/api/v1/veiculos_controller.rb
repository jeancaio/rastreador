class Api::V1::VeiculosController < Api::V1::BaseController


  def get_veiculos
    @cliente = verificar_cliente
    raise "Cliente não encontrado" unless @cliente

    @veiculos = @cliente.veiculos

    if @veiculos
      render json: @veiculos
    else
      raise "Veículo não encontrado"
    end

  rescue StandardError => error
   render json: error
  end

end
