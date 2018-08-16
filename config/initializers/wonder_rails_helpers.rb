WonderRailsHelpers.configure do |config|
  config.require_modules = [
    # view helpers
    :action_helper,        # necessita gem 'rails-i18n'
    :app_helper,
    :boolean_helper,
    :bootstrap_helper,
    :date_time_helper,
    :error_helper,
    :model_name_helper,

    # outras libs
    :wonder_crypt
  ]
end
