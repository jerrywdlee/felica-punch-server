json.partial! "punch_logs/punch_log", punch_log: @punch_log
json.user_name Card.search(@punch_log.card_uid).first.name
