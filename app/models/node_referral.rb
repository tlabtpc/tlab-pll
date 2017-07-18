class NodeReferral < ApplicationRecord
  belongs_to :node, required: true
  belongs_to :referral, required: true
end
