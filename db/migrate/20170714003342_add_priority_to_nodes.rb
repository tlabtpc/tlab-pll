class AddPriorityToNodes < ActiveRecord::Migration[5.0]
  def change
    add_column :nodes, :priority, :integer, default: 0, null: false
  end
end
