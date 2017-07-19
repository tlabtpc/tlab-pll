class AddPositionToNodeReferrals < ActiveRecord::Migration[5.0]
  def change
    add_column :node_referrals, :position, :integer, default: 0, null: false
    add_column :node_referrals, :id, :primary_key
  end
end
