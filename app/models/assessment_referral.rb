class AssessmentReferral < ApplicationRecord
  belongs_to :assessment, required: true
  belongs_to :referral, required: true

  def self.with_missing_referrals
    where("referrals.id IS NULL")
      .joins(
        "LEFT JOIN referrals ON "\
          "assessment_referrals.referral_id = referrals.id"
      )
  end

  def has_usefulness?
    self.useful != nil
  end
end
