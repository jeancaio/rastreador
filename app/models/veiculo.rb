class Veiculo < ApplicationRecord
  belongs_to :user
  has_many :posicoes, dependent: :destroy

  def to_s
    "#{marca} - #{modelo}"
  end
end
