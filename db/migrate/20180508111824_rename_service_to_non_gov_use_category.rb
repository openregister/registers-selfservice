class RenameServiceToNonGovUseCategory < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :service, :non_gov_use_category
  end
end
