class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

 has_many :veiculos, class_name: 'Veiculo', foreign_key: :user_id, dependent: :destroy

 scope :clientes, -> {where(admin: false)}
 def to_s
   nome
 end

 def gerar_token_integracao!
   begin
     self.token_integracao = SecureRandom.hex
   end while self.class.exists?(token_integracao: token_integracao)

   self.save!
 end
end
