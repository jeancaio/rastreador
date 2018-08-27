class Veiculo < ApplicationRecord
  belongs_to :user
  has_many :posicoes, dependent: :destroy

  def to_s
    "#{marca} - #{modelo}"
  end

  def gerar_token_integracao!
    begin
      self.token_integracao = SecureRandom.hex
    end while self.class.exists?(token_integracao: token_integracao)

    self.save!
  end
end
