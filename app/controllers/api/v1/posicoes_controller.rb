class Api::V1::PosicoesController < Api::V1::BaseController

  def post_posicoes
    # @veiculo = verificar_veiculo
    @veiculo = Veiculo.find_by(token_integracao: params[:token])
    raise "Veículo não encontrado" unless @veiculo
    puts '---------VEÍCULO ENCONTRADO-------'
    raise "Posição invalida" if params[:coordenadas_geograficas] == "-0.000000,-0.000000"

    @posicao = Posicao.new(coordenadas_geograficas: params[:coordenadas_geograficas], captured_at: DateTime.now - 3.hours, veiculo: @veiculo)


    if @posicao.save!
      return render json: @posicao, status: 200
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

  def to_speed
    @veiculo = Veiculo.find_by(token_integracao: params[:token_veiculo])
    raise "Veículo não encontrado" unless @veiculo

    inicio = @veiculo.posicoes.last(2).first
    final = @veiculo.posicoes.last

    ponto1 = inicio.coordenadas_geograficas
    ponto2 = final.coordenadas_geograficas

    tempo1 = inicio.captured_at
    tempo2 = final.captured_at

    tempo = tempo2 - tempo1

    resposta = {
      inicio: ponto1,
      final: ponto2,
      tempo: tempo
    }
    render json: resposta

  rescue StandardError => error
   render json: error
  end

end
