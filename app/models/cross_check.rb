class CrossCheck < ApplicationRecord
  STEPS = %w(details info deadlines residence consulted actions support).freeze

  belongs_to :assessment, required: true
end
