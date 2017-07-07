class Node < ApplicationRecord
  belongs_to :parent_node, class_name: "Node"
  has_many :children, class_name: "Node", foreign_key: :parent_node_id
  has_many :referrals, foreign_key: :terminal_node_id

  scope :terminal,   -> { where(terminal: true) }
  scope :counties,   -> { where(is_county: true) }
  scope :categories, -> { where(is_category: true) }

  def self.root
    find_or_create_by(root: true)
  end
end