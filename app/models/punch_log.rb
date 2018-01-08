class PunchLog < ApplicationRecord
  belongs_to :card, foreign_key: :card_uid, primary_key: :card_uid
  def self.log_card_user
    PunchLog.joins(:card => :user)
    .select("users.name, users.slack_name, cards.description, punch_logs.*")
  end

  def self.search(params)
    user_id = params.dig(:User, :user_id)
    time_span = params.dig(:PunchLog, :time_span)
    case true
    when !user_id.to_s.empty? && !time_span.to_s.empty?
      time_start = DateTime.parse(time_span).beginning_of_month
      time_end = DateTime.parse(time_span).end_of_month
      PunchLog.log_card_user
      .where('users.id = ?', params.dig(:User, :user_id))
      .where(created_at: time_start...time_end)
    when !user_id.to_s.empty?
      PunchLog.log_card_user.where('users.id = ?', params.dig(:User, :user_id))
    when !time_span.to_s.empty?
      time_start = DateTime.parse(time_span).beginning_of_month
      time_end = DateTime.parse(time_span).end_of_month
      PunchLog.log_card_user
      .where(created_at: time_start...time_end)
    else
      PunchLog.log_card_user
    end
  end

  def self.time_span
    time_start = PunchLog.all.first.created_at.localtime.beginning_of_month
    time_end = PunchLog.all.last.created_at.localtime.end_of_month
    time_span = []
    while time_start < time_end
      # time_span << { :time_start => time_start, :label => time_start.strftime("%Y-%m") }
      time_span << [time_start.strftime("%Y-%m"), time_start]
      time_start = time_start.next_month.beginning_of_month
    end
    return time_span.reverse
  end
end
