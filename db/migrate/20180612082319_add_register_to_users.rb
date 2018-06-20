class AddRegisterToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :register, :string
  end
end
