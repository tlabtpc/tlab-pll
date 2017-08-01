class RemoveIsUsefulColumnFromAssessmentReferrals < ActiveRecord::Migration[5.0]
  def change
    remove_column :assessment_referrals, :is_useful
  end
end
