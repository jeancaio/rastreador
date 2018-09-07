class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :set_cliente, only: [:show, :edit, :update, :destroy, :gerar_token]

  def index
    @clientes = User.clientes.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show
  end

  def new
    @cliente = User.new
  end

  def edit
  end

  def create
    @cliente = User.new(cliente_params)

    if @cliente.save
      redirect_to admin_users_path, notice: 'Cliente criado com sucesso.'
    else
      render :new
    end
  end

  def update
    if @cliente.update(cliente_params)
      redirect_to admin_users_path, notice: 'Cliente alterado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @cliente.destroy
    redirect_to admin_users_path, notice: 'Cliente excluído com sucesso.'
  end

  def gerar_token
    @cliente.gerar_token_integracao!
    redirect_to admin_user_path(@cliente), notice: "Novo token gerado com sucesso"
  rescue StandardError => error
    redirect_to admin_user_path(@cliente), alert: "Erro ao gerar token: #{error.message}"
  end

  private

  def set_cliente
    @cliente = User.find(params[:id])
  end

  def cliente_params
    params.require(:user).permit(:email, :nome, :password, :password_confirmation)
  end
end
