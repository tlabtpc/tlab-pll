class AddDescriptionToNode < ActiveRecord::Migration[5.0]
  def change
    add_column :nodes, :description, :string
  end
end
