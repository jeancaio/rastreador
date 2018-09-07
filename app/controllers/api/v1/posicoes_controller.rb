class Api::V1::PosicoesController < Api::V1::BaseController

  def post_posicoes
    # @veiculo = verificar_veiculo
    @veiculo = Veiculo.find_by(token_integracao: params[:token])
    puts '---------VEÍCULO ENCONTRADO-------'
    @posicao = Posicao.new(coordenadas_geograficas: params[:coordenadas_geograficas], captured_at: params[:captured_at].to_datetime, veiculo: @veiculo)

    if @posicao.save!
      puts '---------POST POSICAO-------'
      render json: @posicao, status: 200
    else
      render json: @posicao.errors, status: :unprocessable_entity
    end
  rescue StandardError => error
   render json: error
  end

  def get_last_position
    @cliente = verificar_cliente
    @veiculo = @cliente.veiculos.find_by(token_integracao: params[:token_veiculo])

    if @veiculo
      render json: @veiculo.posicoes.last
    else
      raise "Veículo não encontrado"
    end

  rescue StandardError => error
   render json: error
  end

end
