require 'csv'

bom = %w(EF BB BF).map { |e| e.hex.chr }.join

if params.dig :PunchLog, :generate_record
  CSV.generate(bom) do |csv|
    csv_column_names = %w(UserName PunchIn PunchOut WorkTime)
    csv << csv_column_names
    @records.each do |record|
      csv_column_values = [
      record[:name],
      record[:punch_in] ? record[:punch_in].localtime : "",
      record[:punch_out] ? record[:punch_out].localtime : "",
      record[:work_time]
    ]
    csv << csv_column_values
    end
  end
else
  CSV.generate(bom) do |csv|
  csv_column_names = %w(UserName CardDescription CardUid CardType CreatedAt UpdatedAt)
  csv << csv_column_names
  @punch_logs.each do |punch_log|
    csv_column_values = [
      punch_log.name,
      punch_log.description,
      punch_log.card_uid,
      punch_log.card_type,
      punch_log.created_at.localtime,
      punch_log.updated_at.localtime
    ]
    csv << csv_column_values
    end
  end
end

