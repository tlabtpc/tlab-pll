class AddNoReferralsToNode < ActiveRecord::Migration[5.0]
  def change
    add_column :nodes, :no_referrals, :boolean, default: false
  end
end
