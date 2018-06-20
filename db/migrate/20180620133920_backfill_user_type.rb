class BackfillUserType < ActiveRecord::Migration[5.1]
  def change
    User.where(user_type: nil).where.not(api_key: nil).update_all(user_type: :api)
    User.where(api_key: nil, user_type: nil).update_all(user_type: :download)
  end
end
