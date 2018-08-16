class Admin::ClientesController < ApplicationController
  layout 'admin'
  before_action :set_cliente, only: [:show, :edit, :update, :destroy]

  def index
    @clientes = Cliente.all.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show
  end

  def new
    @cliente = Cliente.new
  end

  def edit
  end

  def create
    @cliente = Cliente.new(cliente_params)

    if @cliente.save
      redirect_to admin_clientes_path, notice: 'Cliente criado com sucesso.'
    else
      render :new
    end
  end

  def update
    if @cliente.update(cliente_params)
      redirect_to admin_clientes_path, notice: 'Cliente alterado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @cliente.destroy
    redirect_to admin_clientes_path, notice: 'Cliente excluído com sucesso.'
  end

  private

  def set_cliente
    @cliente = Cliente.find(params[:id])
  end

  def cliente_params
    params.require(:cliente).permit(:email, :nome, :password, :password_confirmation)
  end
end
