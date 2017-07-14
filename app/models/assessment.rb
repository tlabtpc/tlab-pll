class Assessment < ApplicationRecord
  has_secure_token

  has_many :assessment_nodes
  has_many :nodes, through: :assessment_nodes
  has_many :non_terminal_nodes, -> { where(terminal: false) }, through: :assessment_nodes, source: :node

  has_one :terminal_node, -> { find_by(terminal: true) }

  has_one :category_node, -> { find_by(is_category: true) }
  has_one :county_node,   -> { find_by(is_county: true) }

  has_one :cross_check

  # after terminal node is populated, create primary, secondary, special referral records
  has_many :assessment_referrals
  has_many :referrals, through: :assessment_referrals

  has_many :primary_referrals,
    -> { where(type: ['PrimaryReferral', 'SpecialReferral']) },
    through: :assessment_referrals,
    source: :referral

  has_many :secondary_referrals,
    -> { where(type: 'SecondaryReferral') },
    through: :assessment_referrals,
    source: :referral

  def revert_last_node!
    non_terminal_nodes.last.tap { nodes.last&.destroy }
  end

  def referral_ids=(ids)
    Array(ids).each { |id| self.assessment_referrals.build(referral_id: id) }
  end
end
