class AssessmentNode < ApplicationRecord
  belongs_to :assessment, required: true
  belongs_to :node, required: true
end
