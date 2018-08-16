crumb :root do
  link "Home", root_path
end
crumb :clientes do
  link Cliente.model_name.human(count: 2), admin_clientes_path
  parent :root
end
crumb :cliente do |cliente|
  link cliente.to_s, admin_cliente_path(cliente)
  parent :clientes
end
crumb :cliente_edit do |cliente|
  link t('views.actions.do_edit'), edit_admin_cliente_path(cliente)
  parent :cliente, cliente
end
crumb :cliente_new do
  link t('views.actions.new-fem')
  parent :clientes
end
