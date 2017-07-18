class Node < ApplicationRecord
  belongs_to :parent_node, class_name: "Node"
  has_many :children, -> { order(position: :asc) }, class_name: "Node", foreign_key: :parent_node_id
  has_many :node_referrals, -> { order(position: :asc) }
  has_many :referrals, through: :node_referrals

  scope :terminal, -> { where(terminal: true) }
  scope :counties, -> { where(is_county: true) }
  scope :categories, -> { where(is_category: true) }

  def primary_referrals=(referral_titles)
    referral_titles.each_with_index do |referral_title, position|
      self.node_referrals.find_or_create_by(
        referral: PrimaryReferral.find_by(title: referral_title)
      ).update(
        position: position
      )
    end if terminal?
  end

  def self.root
    find_by(root: true)
  end

  def to_param
    [id, title.parameterize].join("-")
  end
end
