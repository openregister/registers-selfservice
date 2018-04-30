class IsGovernmentBoolean < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_government, :boolean
  end
end
