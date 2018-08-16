class Formatter
  def conteudo_resposta_formatter(selecao = nil, multi_selecao = nil, texto = nil)
    value = { respostas: {} }

    value[:respostas][:selecao] = selecao if selecao.present?

    if multi_selecao.present?
      multi_selecao.delete_at(0)
      value[:respostas][:multi_selecao] = multi_selecao if multi_selecao[0].present?
    end

    value[:respostas][:texto] = texto if texto.present?

    value.to_json
  end
end
