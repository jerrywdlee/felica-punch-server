class Card < ApplicationRecord
  belongs_to :user
  def self.card_user
    User.left_joins(:cards).select("users.name, cards.*")
    # p @card_user.first.name
  end
  def self.search(card_uid)
    if card_uid
      Card.card_user.where('cards.card_uid = ?', card_uid)
    else
      Card.card_user
    end
  end
  def card_user_label
    "#{name} - #{card_uid}"
  end
end
