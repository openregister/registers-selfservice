require 'securerandom'

class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :service
      t.string :department
      t.uuid :uuid

      t.timestamps
    end
  end
end
