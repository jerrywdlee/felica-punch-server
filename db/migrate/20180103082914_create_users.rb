class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :pass
      t.text :description
      t.string :slack_url
      t.string :slack_room_id

      t.timestamps
    end
  end
end
