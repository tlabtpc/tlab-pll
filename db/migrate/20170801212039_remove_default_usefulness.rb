class RemoveDefaultUsefulness < ActiveRecord::Migration[5.0]
  def change
    change_column_default(:assessment_referrals, :useful, nil)
  end
end
