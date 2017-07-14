class AddActionItemsToCrossCheck < ActiveRecord::Migration[5.0]
  def change
    add_column :cross_checks, :action_items, :jsonb, null: false, default: []
    drop_table :action_items
    drop_table :cross_check_action_items
  end
end
