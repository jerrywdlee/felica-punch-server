class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.integer :user_id
      t.string :card_uid
      t.integer :card_type
      t.text :description

      t.timestamps
    end
  end
end
