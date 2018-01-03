class CreatePunchLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :punch_logs do |t|
      t.string :card_uid
      t.integer :card_type

      t.timestamps
    end
  end
end
