class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.string :device_uid
      t.text :description
      t.string :param_1

      t.timestamps
    end
  end
end
