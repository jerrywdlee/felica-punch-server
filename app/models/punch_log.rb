class PunchLog < ApplicationRecord
  belongs_to :card, foreign_key: :card_uid, primary_key: :card_uid
  def self.log_card_user
    PunchLog.joins(:card => :user)
    .select("users.name, users.slack_name, cards.description, punch_logs.*")
  end

  def self.search(params)
    case true
    when params.key?(:card_uid)
      PunchLog.log_card_user.where('cards.card_uid = ?', params[:card_uid])
    when params.key?(:name)
      PunchLog.log_card_user.where('users.name = ?', params[:name])
    else
      PunchLog.log_card_user
    end
  end
end
