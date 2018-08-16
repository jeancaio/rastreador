module ApplicationHelper
  def current_admin
    current_user if current_user.admin?
  end

  def link_icon_to(path, text, icon, options = {})
    WViewHelpers::LinkIconTo.new.link_icon_to(path, text, icon, options)
  end

  def link_icon_to_edit(path)
    WViewHelpers::LinkIconTo.new.link_icon_to_edit(path)
  end

  def link_icon_to_destroy(path, options = {})
    WViewHelpers::LinkIconTo.new.link_icon_to_destroy(path, options)
  end

  def link_icon_to_back(path)
    WViewHelpers::LinkIconTo.new.link_icon_to_back(path)
  end

  def link_icon_to_new(path, label, options = {})
    WViewHelpers::LinkIconTo.new.link_icon_to_new(path, label, options)
  end

  def save_button
    render partial: 'shared/button_save'
  end
end
