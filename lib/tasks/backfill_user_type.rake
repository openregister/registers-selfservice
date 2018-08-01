namespace :registers_selfservice do
  task backfill_user_type: :environment do
    User.where(user_type: nil).find_each do |u|
      u.api_key.present? ? u.update_attribute(:user_type, :api) : u.update_attribute(:user_type, :download)
    end
  end
end
