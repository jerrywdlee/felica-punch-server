class Card < ApplicationRecord
  belongs_to :user
  has_many :punch_log, foreign_key: :card_uid, primary_key: :card_uid
  def self.card_user
    Card.joins(:user).select("users.name, users.slack_url, users.slack_room_id, users.slack_name, cards.*")
    # p @card_user.first.name
  end
  def self.search(params)
    case true
    when params.key?(:card_uid)
      Card.card_user.where('cards.card_uid = ?', params[:card_uid])
    when params.key?(:name)
      Card.card_user.where('users.name = ?', params[:name])
    else
      Card.card_user
    end
    # if card_uid
    #   Card.card_user.where('cards.card_uid = ?', card_uid)
    # else
    #   Card.card_user
    # end
  end
  def card_user_label
    "#{name} - #{card_uid}"
  end
end
