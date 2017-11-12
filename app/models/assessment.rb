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

  scope :by_county, -> {
     where(test: false)
    .joins(:assessment_nodes)
    .joins("INNER JOIN nodes ON nodes.id = assessment_nodes.node_id AND nodes.is_county IS TRUE")
    .group("nodes.title")
    .count
  }

  scope :by_category, -> {
     where(test: false)
    .joins(:assessment_nodes)
    .joins("INNER JOIN nodes ON nodes.id = assessment_nodes.node_id AND nodes.is_category IS TRUE")
    .group("nodes.title")
    .count
  }

  scope :by_week, -> {
     where(test: false)
    .select("date_trunc('week', created_at::date) as week")
    .select("COUNT(id) as count")
    .group("week")
    .reduce({}) { |hash, result| hash[result.week.to_date] = result.count; hash }
  }

  scope :by_progress, -> {
     where(test: false)
    .joins("LEFT OUTER JOIN (
      SELECT assessments.id,
        CASE WHEN assessments.has_terminal_node IS FALSE THEN '1 - Incomplete, no referrals given'
             WHEN c.id IS NULL                           THEN '2 - Completed, but no cross check requested'
             WHEN c.caseworker_email IS NULL             THEN '3 - Cross check requested, abandoned before email entered'
             WHEN jsonb_array_length(c.action_items) = 0 THEN '4 - Cross check requested, abandoned before complete'
             ELSE                                             '5 - Completed assessment and completed cross check'
             END
      AS status
      FROM assessments
        LEFT OUTER JOIN cross_checks c ON c.assessment_id = assessments.id
        LEFT OUTER JOIN (
          SELECT count(*) as count, assessment_referrals.assessment_id as assessment_id
          FROM assessments
          INNER JOIN assessment_referrals ON assessment_referrals.assessment_id = assessments.id
          GROUP BY assessment_referrals.assessment_id
        ) a ON a.assessment_id = assessments.id
      ) b ON b.id = assessments.id")
    .group("status")
    .count
  }

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
    [county_name&.downcase, id, created_at.strftime("%Y%m%d")].compact.join('-')
  end

  def reference_id
    [id, created_at.strftime("%Y%m%d")].join('-')
  end

  def county_name
    nodes.counties.pluck(:title).first
  end
end
