class AddIconToNodes < ActiveRecord::Migration[5.0]
  def change
    add_column :nodes, :icon, :string
  end
end
