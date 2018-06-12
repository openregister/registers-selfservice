class MoveDownloadUsersToUsers < ActiveRecord::Migration[5.1]
  def change
    DownloadUsers.find_each do |download_user|
      download_user.users.create(
        email: download_user.email,
        register: download_user.register,
        non_gov_use_category: download_user.non_gov_use_category,
        department: download_user.department,
        is_government: download_user.is_government
      )
    end

    # execute <<-SQL_END
    #   INSERT INTO users (email, register, department, is_government, non_gov_use_category)


    #   SELECT 'DownloadUser', email, register, department, is_government, non_gov_use_category

    #   FROM workshops;
    # SQL_END
  end
end
