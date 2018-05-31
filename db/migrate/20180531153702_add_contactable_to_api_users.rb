class AddContactableToApiUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :contactable, :boolean
  end
end
