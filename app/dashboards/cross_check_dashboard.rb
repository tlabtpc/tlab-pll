require "administrate/base_dashboard"

class CrossCheckDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    assessment_id: Field::Number,
    id: Field::Number,
    reference_id: Field::String,
    details: Field::Text,
    deadlines: Field::Text,
    first_name: Field::String,
    last_name: Field::String,
    county: Field::String,
    home_county: Field::String,
    category: Field::String,
    subcategory: Field::String,
    action_items: Field::String,
    caseworker_phone: Field::String,
    caseworker_email: Field::String,
    caseworker_organization: Field::String,
    client_is_long_term: Field::String.with_options(searchable: false),
    client_is_homeless: Field::Boolean,
    client_is_in_issue_county: Field::Boolean,
    client_has_consulted_attorney: Field::String.with_options(searchable: false),
    support_level: Field::String.with_options(searchable: false),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    action_items: Field::String.with_options(searchable: false),
    last_name: Field::String,
    county_node_id: Field::Number,
    client_has_attorney_representation: Field::String.with_options(searchable: false),
    primary_referral_titles: Field::String,
    created_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :created_at,
    :caseworker_organization,
    :caseworker_email,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :reference_id,
    :created_at,
    :first_name,
    :last_name,
    :caseworker_phone,
    :caseworker_organization,
    :county,
    :home_county,
    :category,
    :subcategory,
    :details,
    :deadlines,
    :client_has_consulted_attorney,
    :support_level,
    :client_is_long_term,
    :primary_referral_titles,
    :action_items
  ].freeze
end
