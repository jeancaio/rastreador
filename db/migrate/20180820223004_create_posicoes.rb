class CreatePosicoes < ActiveRecord::Migration[5.1]
  def change
    create_table :posicoes do |t|
      t.string :coordenadas_geograficas
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
