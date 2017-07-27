class Assessment < ApplicationRecord
  has_secure_token

  has_many :assessment_nodes

  has_many :terminal_assessment_nodes,
    -> { joins(:node).where("nodes.terminal": true) },
    source: :assessment_node,
    class_name: "AssessmentNode"

  has_many :non_terminal_assessment_nodes,
    -> { joins(:node).where("nodes.terminal": false) },
    source: :assessment_node,
    class_name: "AssessmentNode"

  has_many :nodes, through: :assessment_nodes

  has_many :terminal_nodes,
    -> { where(terminal: true) },
    through: :assessment_nodes, source: :node

  has_many :non_terminal_nodes,
    -> { where(terminal: false) },
    through: :assessment_nodes, source: :node

  has_many :include_in_summary_nodes,
    -> { where(include_in_summary: true) },
    through: :assessment_nodes, source: :node

  has_one :cross_check

  has_many :assessment_referrals
  has_many :referrals, through: :assessment_referrals

  has_many :primary_referrals,
    -> { where(type: 'PrimaryReferral') },
    through: :assessment_referrals,
    source: :referral

  has_many :secondary_referrals,
    -> { where(type: 'SecondaryReferral') },
    through: :assessment_referrals,
    source: :referral

  has_many :special_referrals,
    -> { where(type: 'SpecialReferral') },
    through: :assessment_referrals,
    source: :referral

  def featured_referrals
    ordered_primary_referrals + special_referrals
  end

  def ordered_primary_referrals
    PrimaryReferral.joins(:node_referrals)
      .where("node_referrals.node_id": terminal_nodes.pluck(:id))
      .order("node_referrals.position")
  end

  def referral_ids=(ids)
    (Array(ids) - self.referral_ids).each do |id|
      self.assessment_referrals.build(referral_id: id)
    end
  end

  def to_param
    [id, created_at.strftime("%Y%m%d")].join('-')
  end
  alias :reference_id :to_param
end
