class AddTestColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :assessments, :test, :boolean, default: false, null: false
  end
end
