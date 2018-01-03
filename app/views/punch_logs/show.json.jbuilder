json.partial! "punch_logs/punch_log", punch_log: @punch_log
@card_info = Card.search(@punch_log.card_uid).first
json.user_name @card_info.name
json.slack_url @card_info.slack_url
