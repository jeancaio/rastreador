class Api::V1::PosicoesController < Api::V1::BaseController

  def post_posicoes
    @veiculo = verificar_veiculo
    @posicao = Posicao.new(coordenadas_geograficas: params[:coordenadas_geograficas], captured_at: params[:captured_at].to_datetime, veiculo: @veiculo)

    if @posicao.save!
      render json: @posicao, status: 200
    else
      render json: @posicao.errors, status: :unprocessable_entity
    end
  rescue StandardError => error
   render json: error
  end

end
