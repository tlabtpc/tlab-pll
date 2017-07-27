class UpdateColumnNameToBeCountyGeneric < ActiveRecord::Migration[5.0]
  def change
    rename_column :cross_checks, :client_is_in_sf, :client_is_in_issue_county
  end
end
