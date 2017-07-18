class AddNodeReferrals < ActiveRecord::Migration[5.0]
  def change
    create_table :node_referrals, :id => false do |t|
      t.integer :node_id
      t.integer :referral_id
    end
  end
end
