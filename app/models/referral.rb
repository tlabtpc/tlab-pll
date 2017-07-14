class Referral < ApplicationRecord
  belongs_to :terminal_node, required: false, class_name: "Node"
end
