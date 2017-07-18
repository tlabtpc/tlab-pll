class AssessmentNode < ApplicationRecord
  belongs_to :assessment, required: true
  belongs_to :node, required: true

  before_destroy :remove_referrals

  private

  def remove_referrals
    assessment.referrals.delete(node.referrals)
  end
end
