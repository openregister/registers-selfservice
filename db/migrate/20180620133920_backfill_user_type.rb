class BackfillUserType < ActiveRecord::Migration[5.1]
  def change
    User.where(user_type: nil).find_each do |u|
      if u.api_key.present?
        u.update(user_type: :api)
      else
        u.update(user_type: :download)
      end
    end
  end
end
