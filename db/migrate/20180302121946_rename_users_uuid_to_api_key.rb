class RenameUsersUuidToApiKey < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :uuid, :api_key
  end
end
