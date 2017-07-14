class Assessment < ApplicationRecord
  has_secure_token

  has_many :assessment_nodes
  has_many :nodes, through: :assessment_nodes
  has_many :non_terminal_nodes, -> { where(terminal: false) }, through: :assessment_nodes, source: :node

  has_one :cross_check

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

  def terminal_assessment_node
    assessment_nodes.joins(:node).where("terminal IS TRUE").first
  end

  def last_assessment_node
    assessment_nodes.order(:created_at).last
  end

  def referral_ids=(ids)
    Array(ids).each { |id| self.assessment_referrals.build(referral_id: id) }
  end
end
