class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 has_many :veiculos, class_name: 'Veiculo', foreign_key: :user_id, dependent: :destroy

 scope :clientes, -> {where(admin: false)}
 def to_s
   nome
 end
end
