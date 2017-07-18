class SplitCaseworkerNameToTwoFields < ActiveRecord::Migration[5.0]
  def change
    rename_column :cross_checks, :caseworker_name, :first_name
    add_column :cross_checks, :last_name, :string
  end
end
