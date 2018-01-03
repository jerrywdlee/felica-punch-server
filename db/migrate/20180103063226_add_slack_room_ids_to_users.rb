class AddSlackRoomIdsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :slack_room_id, :string
  end
end
