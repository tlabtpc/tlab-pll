class AddReferralPriority < ActiveRecord::Migration[5.0]
  def change
    add_column :referrals, :priority, :integer, default: 1, null: false
  end
end
