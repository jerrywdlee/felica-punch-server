# json.array! @cards, partial: 'cards/card', as: :card

json.array!(@cards) do |card|
  json.partial! "cards/card", card: card
  json.user_name card.name
end