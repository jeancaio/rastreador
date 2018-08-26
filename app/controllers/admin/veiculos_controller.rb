class Admin::VeiculosController < ApplicationController
  layout 'admin'
  before_action :set_veiculo, only: [:show, :edit, :update, :destroy]
  before_action :set_cliente, only: [:index, :new, :create]

  def index
    @veiculos = @cliente.veiculos.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show
  end

  def new
    @veiculo = @cliente.veiculos.new
  end

  def edit
  end

  def create
    @veiculo = @cliente.veiculos.new(veiculos_params)

    if @veiculo.save
      redirect_to admin_user_veiculos_path(@cliente), notice: 'Veículo criado com sucesso.'
    else
      render :new
    end
  end

  def update
    if @veiculo.update(veiculos_params)
      redirect_to admin_veiculo_path(@veiculo), notice: 'Veículo alterado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @veiculo.destroy
    redirect_to admin_clientes_path, notice: 'Cliente excluído com sucesso.'
  end

  private

  def set_veiculo
    @veiculo = Veiculo.find(params[:id])
  end

  def set_cliente
    @cliente = Cliente.find(params[:user_id])
  end

  def veiculos_params
    params.require(:veiculo).permit(:marca, :modelo, :cor, :placa)
  end
end
