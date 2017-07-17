class Referral < ApplicationRecord
  has_many :node_referrals
  has_many :nodes, through: :node_referrals

  scope :primary, -> { where(type: "PrimaryReferral") }
  scope :non_secondary, -> { where.not(type: "SecondaryReferral") }
end
