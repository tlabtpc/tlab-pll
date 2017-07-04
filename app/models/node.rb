class Node < ApplicationRecord
  belongs_to :parent_node, class_name: "Node"
  has_many :children, class_name: "Node", foreign_key: :parent_node_id
  has_many :referrals, foreign_key: :terminal_node_id

  INITIAL_NODE_TITLE = "Initial Node".freeze

  def self.initial
    Node.find_by(title: INITIAL_NODE_TITLE) # TODO: improve
  end
end
