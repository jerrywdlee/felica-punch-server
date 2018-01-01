json.extract! punch_log, :id, :card_uid, :card_type, :created_at, :updated_at
json.url punch_log_url(punch_log, format: :json)
