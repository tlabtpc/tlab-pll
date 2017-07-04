class AddTokenToAssessment < ActiveRecord::Migration[5.0]
  def change
    rename_column :assessments, :user_cookie, :token
  end
end
