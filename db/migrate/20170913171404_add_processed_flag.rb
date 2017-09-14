class AddProcessedFlag < ActiveRecord::Migration[5.0]
  def change
    add_column :cross_checks, :processed, :boolean, default: false, null: false
  end
end
