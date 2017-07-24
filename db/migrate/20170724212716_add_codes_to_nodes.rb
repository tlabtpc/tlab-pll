class AddCodesToNodes < ActiveRecord::Migration[5.0]
  def change
    add_column :nodes, :code, :string
  end
end
