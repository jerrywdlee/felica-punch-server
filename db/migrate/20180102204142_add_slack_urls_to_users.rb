class AddSlackUrlsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :slack_url, :string
  end
end
