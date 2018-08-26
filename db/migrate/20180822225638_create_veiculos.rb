class CreateVeiculos < ActiveRecord::Migration[5.1]
  def change
    create_table :veiculos do |t|
      t.string :modelo
      t.string :marca
      t.string :cor
      t.string :placa
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
