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
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    action_items: Field::String.with_options(searchable: false),
    last_name: Field::String,
    county_node_id: Field::Number,
    client_has_attorney_representation: Field::String.with_options(searchable: false),
    primary_referral_titles: Field::String,
    created_at_date: Field::String,
    created_at_time: Field::String
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

  TITLE_MAP = {
    reference_id: "Reference Number",
    created_at_date: "Date Created",
    created_at_time: "Timestamp",
    first_name: "Caseworker First Name",
    last_name: "Caseworker Last Name",
    caseworker_phone: "Caseworker Phone",
    caseworker_email: "Caseworker Email",
    caseworker_organization: "Caseworker Organization",
    category: "Category of legal help",
    subcategory: "Sub-category of legal help",
    county: "Issue county",
    home_county: "Client's home county",
    details: "Details",
    primary_referral_titles: "Primary Referrals provided",
    action_items: "Support actions selected",
    client_has_consulted_attorney: "Client has consulted attorney",
    deadlines: "Deadlines",
    client_is_long_term: "Client > 2 months?",
    client_is_homeless: "Client in housing search?"
  }.freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = TITLE_MAP.keys.freeze
end
