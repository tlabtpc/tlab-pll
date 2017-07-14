class Referral < ApplicationRecord
  belongs_to :terminal_node, required: false, class_name: "Node"

  scope :non_secondary, -> { where.not(type: "SecondaryReferral") }
end
