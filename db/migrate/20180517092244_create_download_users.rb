class CreateDownloadUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :download_users do |t|
      t.string :email
      t.string :non_gov_use_category
      t.string :department
      t.string :register
      t.boolean :is_government

      t.timestamps
    end
  end
end
