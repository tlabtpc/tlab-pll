class Referral < ApplicationRecord
  belongs_to :terminal_node, required: false, class_name: "Node"
  scope :non_secondary, -> { where.not(type: "SecondaryReferral") }

  scope :primary,   -> { where(type: "PrimaryReferral") }
  scope :secondary, -> { where(type: "SecondaryReferral") }
  scope :special,   -> { where(type: "SpecialReferral") }
end
