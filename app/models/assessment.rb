class Assessment < ApplicationRecord
  has_secure_token

  has_many :assessment_nodes
  has_many :nodes, through: :assessment_nodes

  has_one :terminal_node, -> { find_by(terminal: true) }

  has_one :category_node, -> { find_by(is_category: true) }
  has_one :county_node,   -> { find_by(is_county: true) }

  # after terminal node is populated, create primary, secondary, special referral records
  has_many :assessment_referrals
  has_many :primary_referrals, through: :assessment_referrals, source: "PrimaryReferral"
  has_many :secondary_referrals, through: :assessment_referrals, source: "SecondaryReferral"
  has_many :special_referrals, through: :assessment_referrals, source: "SpecialReferral"

  def terminate_with!(node)
    return unless node.terminal?
    node.referrals.each { |referral| self.assessment_referrals.build(referral: referral) }
  end
end
