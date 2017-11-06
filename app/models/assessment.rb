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

  scope :by_submitted_at, -> {
     where(test: false)
    .joins("LEFT OUTER JOIN (
      SELECT assessments.id,
        CASE WHEN submitted_at IS NULL THEN 'Left incomplete'
             WHEN a.count > 0          THEN 'Completed, but no referrals issued'
             ELSE                           'Completed and offered referrals'
             END
      AS status
      FROM assessments LEFT OUTER JOIN (
        SELECT count(*) as count, assessment_referrals.assessment_id as assessment_id
        FROM assessments
        INNER JOIN assessment_referrals ON assessment_referrals.assessment_id = assessments.id
        GROUP BY assessment_referrals.assessment_id
      ) a ON a.assessment_id = assessments.id
      ) b ON b.id = assessments.id")
    .group("status")
    .count
  }

  scope :by_cross_check, -> {
     where(test: false)
    .joins("LEFT OUTER JOIN (
      SELECT assessments.id,
        CASE WHEN jsonb_array_length(cross_checks.action_items) > 1 THEN 'Completed'
             WHEN cross_checks.caseworker_email IS NOT NULL         THEN 'Caseworker entered information'
             WHEN cross_checks.id               IS NOT NULL         THEN 'Requested, but left incomplete'
             ELSE                                                        'No cross check requested'
             END
        AS status
      FROM assessments LEFT OUTER JOIN cross_checks ON cross_checks.assessment_id = assessments.id) a ON a.id = assessments.id")
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
