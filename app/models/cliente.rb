class Cliente < User

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
