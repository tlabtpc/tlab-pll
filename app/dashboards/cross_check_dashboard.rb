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
    details: Field::Text,
    deadlines: Field::Text,
    first_name: Field::String,
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
    :assessment_id,
    :id,
    :details,
    :deadlines,
    :first_name,
    :caseworker_phone,
    :caseworker_email,
    :caseworker_organization,
    :client_is_long_term,
    :client_is_homeless,
    :client_is_in_issue_county,
    :client_has_consulted_attorney,
    :support_level,
    :created_at,
    :updated_at,
    :action_items,
    :last_name,
    :county_node_id,
    :client_has_attorney_representation,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  # FORM_ATTRIBUTES = [
  #   :assessment,
  #   :details,
  #   :deadlines,
  #   :first_name,
  #   :caseworker_phone,
  #   :caseworker_email,
  #   :caseworker_organization,
  #   :client_is_long_term,
  #   :client_is_homeless,
  #   :client_is_in_issue_county,
  #   :client_has_consulted_attorney,
  #   :support_level,
  #   :action_items,
  #   :last_name,
  #   :county_node_id,
  #   :client_has_attorney_representation,
  # ].freeze

  # Overwrite this method to customize how cross checks are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(cross_check)
  #   "CrossCheck ##{cross_check.id}"
  # end
end
