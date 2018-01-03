class CreateAdmins < ActiveRecord::Migration[5.1]
  def change
    create_table :admins do |t|
      t.string :email
      t.string :pass
      t.text :description

      t.timestamps
    end
  end
end
