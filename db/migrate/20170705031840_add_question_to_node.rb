class AddQuestionToNode < ActiveRecord::Migration[5.0]
  def change
    add_column :nodes, :question, :string
  end
end
