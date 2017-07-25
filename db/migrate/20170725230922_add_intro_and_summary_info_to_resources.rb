class AddIntroAndSummaryInfoToResources < ActiveRecord::Migration[5.0]
  def change
    add_column :referrals, :intro, :string
    add_column :nodes, :include_in_summary, :boolean
  end
end
