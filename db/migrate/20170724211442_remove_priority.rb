class RemovePriority < ActiveRecord::Migration[5.0]
  def change
    remove_column :referrals, :priority, :integer
  end
end
