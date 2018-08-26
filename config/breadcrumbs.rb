crumb :root do
  link "Home", root_path
end
crumb :users do
  link User.model_name.human(count: 2), admin_users_path
  parent :root
end
crumb :user do |user|
  link user.to_s, admin_user_path(user)
  parent :users
end
crumb :user_edit do |user|
  link t('views.actions.do_edit'), edit_admin_user_path(user)
  parent :user, user
end
crumb :user_new do
  link t('views.actions.new-fem')
  parent :users
end

crumb :veiculos do |user|
  link user.to_s, admin_user_veiculos_path(user)
  parent :users
end
crumb :veiculo do |veiculo|
  link veiculo.to_s
  parent :veiculos, veiculo.user
end
crumb :veiculo_edit do |veiculo|
  link t('views.actions.edit'), edit_admin_veiculo_path(veiculo)
  parent :veiculo, veiculo
end
crumb :veiculo_new do |veiculo|
  link t('views.actions.new')
  parent :veiculos, veiculo.user
end
