class RenamePriorityOnNode < ActiveRecord::Migration[5.0]
  def change
    rename_column :nodes, :priority, :position
  end
end
