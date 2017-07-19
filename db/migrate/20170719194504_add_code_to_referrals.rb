class AddCodeToReferrals < ActiveRecord::Migration[5.0]
  def change
    add_column :referrals, :code, :string
  end
end
