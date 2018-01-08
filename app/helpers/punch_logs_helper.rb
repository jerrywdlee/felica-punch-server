module PunchLogsHelper
  def self.generate_record(punch_logs)
    records = []
    i = 0
    while i < punch_logs.length
      punch_in_rec = punch_logs[i + 1]
      punch_out_rec = punch_logs[i]
      record = {
        :name => punch_out_rec.name,
        :punch_out => punch_out_rec.created_at,
      }
      if punch_in_rec
        record[:punch_in] = punch_in_rec.created_at
        time_due = record[:punch_out] - record[:punch_in]
        record[:work_time] = Time.at(time_due).utc.strftime("%H:%M:%S")
      end
      records << record
      i += 2
    end
    return records.reverse
  end
end
