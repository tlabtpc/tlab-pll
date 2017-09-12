class RemoveOtherDacas < ActiveRecord::Migration[5.0]
  def change
    NodeReferral.joins(:node)
                .joins("INNER JOIN referrals ON referrals.id = node_referrals.referral_id")
                .where("nodes.code": "84e602310a9d9598")
                .where.not("referrals.code": "daca")
                .destroy_all
  end
end
