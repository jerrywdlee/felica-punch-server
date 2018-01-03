class User < ApplicationRecord
  has_many :cards, dependent: :destroy
  # def self.card_user
  #   User.joins(:cards).select("users.*, cards.*")
  #   # p @card_user.first.name
  # end
  def card_user_label
    "#{name} - #{card_uid}"
  end
end
