class AddUsefulToAssessmentReferral < ActiveRecord::Migration[5.0]
  def change
    add_column :assessment_referrals, :useful, :boolean, default: false
  end
end
