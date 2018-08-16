class WViewHelpers::LinkIconTo
  include ActionView::Helpers
  include ActionView::Context
  include Rails.application.routes.url_helpers

  def link_icon_to(path, text, icon, options = {})
    link_class = options[:link_class]
    method     = options[:method]
    remote     = options[:remote]
    data       = options[:data]

    link_to content_tag(:i, '', class: 'fa fa-' + icon.to_s) + ' ' + text, path,
            class: link_class, method: method, remote: remote, data: data
  end

  def link_icon_to_edit(path)
    link_icon_to(path, 'Editar', 'edit', link_class: 'waves-effect waves-light btn cyan lighten-1')
  end

  def link_icon_to_destroy(path, options = {})
    link_class = options.fetch(:class, 'waves-effect waves-light btn red lighten-1')
    link_icon_to(path, 'Excluir', 'minus-circle', link_class: link_class,
                                                  method: :delete, data: { confirm: 'Você tem certeza?' })
  end

  def link_icon_to_back(path)
    link_icon_to(path, 'Voltar', 'arrow-left', link_class: 'waves-effect waves-light btn grey')
  end

  def link_icon_to_new(path, label, options = {})
    link_class = options.fetch(:class, 'waves-effect waves-light btn cyan lighten-1')
    link_icon_to(path, label, 'plus', link_class: link_class)
  end
end
