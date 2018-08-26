class AddVeiculoReferencesToPosicao < ActiveRecord::Migration[5.1]
  def change
    add_reference :posicoes, :veiculo, foreign_key: true, index: true
  end
end
