class IntegracaoVeiculoException < ApplicationException

  attr_reader :code, :error, :messages

  def initialize(code, error, messages = nil)
    @code  = code
    @error = error
    @messages = messages
  end

  def call
    { code: code, success: false, errors: { error: error, messages: messages } }
  end

  def retorno
    { success: false, error: error }
  end

end
