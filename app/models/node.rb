class Node < ApplicationRecord
  belongs_to :parent_node, class_name: "Node"
  has_many :children, class_name: "Node", foreign_key: :parent_node_id
  has_many :node_referrals
  has_many :referrals, through: :node_referrals

  scope :terminal, -> { where(terminal: true) }
  scope :counties, -> { where(is_county: true) }
  scope :categories, -> { where(is_category: true) }

  def primary_referrals=(referral_titles)
    self.referrals = Referral.where(title: referral_titles)
  end

  def self.root
    find_by(root: true)
  end

  def to_param
    [id, title.parameterize].join("-")
  end
end
