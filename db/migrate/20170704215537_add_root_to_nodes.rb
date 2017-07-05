class AddRootToNodes < ActiveRecord::Migration[5.0]
  def change
    add_column :nodes, :root, :boolean, default: false, null: false
  end
end
