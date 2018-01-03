json.extract! user, :id, :name, :email, :pass, :description, :slack_url, :slack_room_id, :slack_name, :created_at, :updated_at
json.url user_url(user, format: :json)
