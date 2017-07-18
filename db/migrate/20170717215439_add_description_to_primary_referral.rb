class AddDescriptionToPrimaryReferral < ActiveRecord::Migration[5.0]
  def change
    add_column :referrals, :description, :text
  end
end
