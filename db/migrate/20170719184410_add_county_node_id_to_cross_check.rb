class AddCountyNodeIdToCrossCheck < ActiveRecord::Migration[5.0]
  def change
    add_column :cross_checks, :county_node_id, :integer
  end
end
