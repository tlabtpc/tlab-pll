class AssessmentReferral < ApplicationRecord
  belongs_to :assessment, required: true
  belongs_to :referral, required: true
end
