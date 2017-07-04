class SecondaryReferral < Referral
  validates :terminal_node, presence: true
end
