class Referral < ApplicationRecord
  belongs_to :terminal_node, required: true, class_name: "Node"
end
