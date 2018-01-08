json.extract! card, :id, :user_id, :card_uid, :card_type, :description, :created_at, :updated_at, :param_1, :param_2, :param_3
json.url card_url(card, format: :json)
