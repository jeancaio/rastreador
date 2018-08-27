class AddTokenIntegracaoToVeiculo < ActiveRecord::Migration[5.1]
  def change
    add_column :veiculos, :token_integracao, :string
  end
end
