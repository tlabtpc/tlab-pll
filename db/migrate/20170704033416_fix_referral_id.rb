class FixReferralId < ActiveRecord::Migration[5.0]
  def change
    rename_column :assessment_referrals, :referrals_id, :referral_id
  end
end
