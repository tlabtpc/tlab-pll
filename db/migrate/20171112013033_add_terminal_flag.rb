class AddTerminalFlag < ActiveRecord::Migration[5.0]
  def change
    add_column :assessments, :has_terminal_node, :boolean, default: false, null: false
    Assessment.find_each { |a| a.update(has_terminal_node: a.terminal_nodes.any?) }
  end
end
