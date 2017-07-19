class Referral < ApplicationRecord
  has_many :node_referrals
  has_many :nodes, through: :node_referrals

  scope :primary,   -> { where(type: "PrimaryReferral") }
  scope :secondary, -> { where(type: "SecondaryReferral") }
  scope :special,   -> { where(type: "SpecialReferral") }

  scope :featured, -> { where.not(type: "SecondaryReferral") }
end
