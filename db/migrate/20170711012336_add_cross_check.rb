class AddCrossCheck < ActiveRecord::Migration[5.0]
  def change
    create_table :cross_checks do |t|
      t.belongs_to :assessment
      t.text :details
      t.text :deadlines
      t.string :caseworker_name
      t.string :caseworker_phone
      t.string :caseworker_email
      t.string :caseworker_organisation
      t.boolean :client_is_long_term
      t.boolean :client_is_homeless
      t.boolean :client_is_in_sf
      t.integer :client_has_consulted_attorney
      t.integer :support_level
      t.timestamps
    end

    create_table :cross_check_action_items do |t|
      t.references :cross_check
      t.references :action_item
      t.timestamps
    end

    create_table :action_items do |t|
      t.string :name
      t.timestamps
    end
  end
end
