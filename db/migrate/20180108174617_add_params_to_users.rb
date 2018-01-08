class AddParamsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :param_1, :string
    add_column :users, :param_2, :string
    add_column :users, :param_3, :string
  end
end
