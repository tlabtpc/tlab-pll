class Assessment < ApplicationRecord
  has_secure_token

  has_many :assessment_nodes
  has_many :nodes, through: :assessment_nodes
  has_many :non_terminal_nodes, -> { where(terminal: false) }, through: :assessment_nodes, source: :node

  has_one :cross_check

  has_many :assessment_referrals
  has_many :referrals, through: :assessment_referrals

  has_many :primary_referrals,
    -> { where(type: 'PrimaryReferral').order(type: :asc) },
    through: :assessment_referrals,
    source: :referral

  has_many :secondary_referrals,
    -> { where(type: 'SecondaryReferral') },
    through: :assessment_referrals,
    source: :referral

  def featured_referrals
    referrals.where(type: ['PrimaryReferral', 'SpecialReferral']).order(type: :asc)
  end

  def referral_ids=(ids)
    Array(ids).each { |id| self.assessment_referrals.build(referral_id: id) }
  end

  def to_param
    [id, created_at.strftime("%Y%m%d")].join('-')
  end
  alias :reference_id :to_param
end
