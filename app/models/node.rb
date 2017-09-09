class Node < ApplicationRecord
  belongs_to :parent_node, class_name: "Node"
  has_many :children, -> { order(position: :asc) }, class_name: "Node", foreign_key: :parent_node_id
  has_many :node_referrals, -> { order(position: :asc) }
  has_many :referrals, through: :node_referrals

  scope :terminal, -> { where(terminal: true) }
  scope :counties, -> { where(is_county: true) }
  scope :categories, -> { where(is_category: true) }

  def primary_referrals=(codes)
    set_referrals(referral_class: PrimaryReferral, records: codes, find_by: :code)
  end

  def secondary_referrals=(titles)
    set_referrals(referral_class: SecondaryReferral, records: titles, find_by: :code)
  end

  def self.root
    find_by(root: true)
  end

  def to_param
    [id, county_name, title.parameterize].compact.join("-")
  end

  def county_name
    return if root
    if parent_node.is_county
      parent_node.title.downcase.parameterize
    else
      parent_node.county_name
    end
  end

  private

  def set_referrals(referral_class:, records:, find_by:)
    records.each_with_index do |record, position|
      if referral = referral_class.find_by(find_by => record)
        self.node_referrals
            .find_or_create_by(referral: referral)
            .update(position: position)
      else
        warn "Could not find #{referral_class} with title '#{title}'. Check the seeds file to ensure the referral exists."
      end
    end
  end
end
