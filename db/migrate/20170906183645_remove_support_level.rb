class RemoveSupportLevel < ActiveRecord::Migration[5.0]
  def change
    remove_column :cross_checks, :support_level, :string
  end
end
