class PrimaryReferral < Referral
  validates :terminal_node, presence: true
end
