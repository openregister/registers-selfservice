class BackfillUserType < ActiveRecord::Migration[5.1]
  def change
    User.where(user_type: nil).find_each do |u|
      u.api_key.present? ? u.update(user_type: :api) : u.update(user_type: :download)
    end
  end
end
