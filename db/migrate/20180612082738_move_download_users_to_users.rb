class MoveDownloadUsersToUsers < ActiveRecord::Migration[5.1]
  def change
    DownloadUser.find_each do |download_user|
      User.create(
        email: download_user.email,
        register: download_user.register,
        non_gov_use_category: download_user.non_gov_use_category,
        department: download_user.department,
        is_government: download_user.is_government,
        api_key: nil,
        contactable: download_user.created_at.between?(Time.utc(2018, 0o5, 30, 18), Time.now)
      )
    end
  end
end
