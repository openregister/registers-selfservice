namespace :registers_selfservice do
  task backfill_user_type: :environment do
    User.where(user_type: nil).find_each do |u|
      u.api_key.present? ? u.update(user_type: :api) : u.update(user_type: :download)
    end
  end
end
