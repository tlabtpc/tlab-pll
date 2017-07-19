class AddClientHasAttorneyRepresentation < ActiveRecord::Migration[5.0]
  def change
    add_column :cross_checks, :client_has_attorney_representation, :integer
  end
end
