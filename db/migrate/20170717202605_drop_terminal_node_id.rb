class DropTerminalNodeId < ActiveRecord::Migration[5.0]
  def change
    remove_column :referrals, :terminal_node_id, :integer
  end
end
