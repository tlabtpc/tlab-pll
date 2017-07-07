class Referral < ApplicationRecord
  belongs_to :terminal_node, required: false, class_name: "Node"

  scope :primary,   -> { where(type: "PrimaryReferral") }
  scope :secondary, -> { where(type: "SecondaryReferral") }
  scope :special,   -> { where(type: "SpecialReferral") }
end
