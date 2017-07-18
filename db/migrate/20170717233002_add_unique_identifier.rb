class AddUniqueIdentifier < ActiveRecord::Migration[5.0]
  def change
    add_column :referrals, :unique_identifier, :string
  end
end
