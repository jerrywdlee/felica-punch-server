json.partial! "punch_logs/punch_log", punch_log: @punch_log
@card_info = Card.search(@punch_log.card_uid).first
json.user_name @card_info.name
json.slack_url @card_info.slack_url
json.slack_room_id @card_info.slack_room_id
json.slack_name @card_info.slack_name
json.description @card_info.description