class Referral < ApplicationRecord
  has_many :node_referrals
  has_many :nodes, through: :node_referrals

  scope :primary,   -> { where(type: "PrimaryReferral") }
  scope :secondary, -> { where(type: "SecondaryReferral") }
  scope :special,   -> { where(type: "SpecialReferral") }
  scope :featured, -> { where.not(type: "SecondaryReferral") }
  scope :hand_edited, -> { where.not(markdown_content: nil) }

  def link_with_protocol(scheme = "https")
    URI.parse(self.link).tap { |uri| uri.scheme ||= scheme }.to_s
  end
end
