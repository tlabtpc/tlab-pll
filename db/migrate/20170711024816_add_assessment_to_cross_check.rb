class AddAssessmentToCrossCheck < ActiveRecord::Migration[5.0]
  def change
    add_column :cross_checks, :assessment_id, :integer, null: false, index: true
  end
end
