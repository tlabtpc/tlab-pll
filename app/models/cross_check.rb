class CrossCheck < ApplicationRecord
  STEPS = %w(new details info deadlines residence consulted actions support).freeze
  belongs_to :assessment, required: true
end
