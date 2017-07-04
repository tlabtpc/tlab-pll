class InitialMigration < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :user_cookie, :string

    # workflow:
    # - user creates an Assessment
    # - Assessment is populated w a user_cookie, which is set on the user's
    #   browser
    # - the users creates a series of responses (either into an array, or a
    #   series of models)
    # - upon creating a response, we check the existing responses to see if
    #   those responses warrant a leaf
    # - if the assessment is granted a leaf, display leaf page
    #   which lists all referrals associated with that leaf
    # - otherwise, determine the next question to receive a response, based
    #   on existing responses

    create_table :assessments do |t|
      t.string :user_cookie
      t.datetime :submitted_at
      t.timestamps
    end

    create_table :counties do |t|
      t.name
      t.timestamps
    end

    create_table :assessment_nodes do |t|
      t.belongs_to :assessment
      t.belongs_to :node
      t.timestamps
    end

    create_table :nodes do |t|
      t.belongs_to :parent_node
      t.boolean :terminal, default: false, null: false
      t.string :node_type
      t.boolean :is_category, default: false, null: false
      t.boolean :is_county, default: false, null: false
      t.string :title
      t.timestamps
    end

    create_table :assessment_referrals do |t|
      t.belongs_to :assessment
      t.references :referrals
      t.boolean :is_useful, default: false, null: false
      t.timestamps
    end

    create_table :referrals do |t|
      t.belongs_to :terminal_node
      t.string :type # "PrimaryReferral", "SecondaryReferral", "SpecialReferral"
      t.string :title
      t.text :description
      t.string :introduction
      t.string :link
      t.timestamps
    end
  end
end
