json.extract! card, :id, :user_id, :card_uid, :card_type, :description, :created_at, :updated_at
json.url card_url(card, format: :json)
