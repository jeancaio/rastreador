class AddTokenIntegracaoToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :token_integracao, :string
  end
end
