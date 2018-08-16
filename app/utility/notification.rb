class Notification
  def push_notification(token, msg)
    registration_ids = [token.to_s] # an array of one or more client registration tokens

    params = { app_id: ENV['APP_ID_NOTIFICATION'],
               contents:  { en: msg },
               include_player_ids: registration_ids
        }

    OneSignal::Notification.create(params: params)
  end
end
