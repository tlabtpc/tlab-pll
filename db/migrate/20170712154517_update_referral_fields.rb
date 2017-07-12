class UpdateReferralFields < ActiveRecord::Migration[5.0]
  def change
    rename_column :referrals, :description, :markdown_content
    remove_column :referrals, :introduction, :text
  end
end
