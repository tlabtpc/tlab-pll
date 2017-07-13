class RenameOrganisationToOrganization < ActiveRecord::Migration[5.0]
  def change
    rename_column :cross_checks, :caseworker_organisation, :caseworker_organization
  end
end
