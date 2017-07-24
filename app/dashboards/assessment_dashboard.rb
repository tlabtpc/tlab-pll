require "administrate/base_dashboard"

class AssessmentDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    token: Field::String,
    reference_id: Field::String,
    submitted_at: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    caseworker_first_name: Field::String,
    caseworker_last_name: Field::String,
    caseworker_email: Field::Email,
    caseworker_phone: Field::String,
    caseworker_organization: Field::String,
    details: Field::Text,
    deadlines: Field::Text
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :reference_id, :created_at, :submitted_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :reference_id,
    :submitted_at,
    :caseworker_first_name,
    :caseworker_last_name,
    :caseworker_email,
    :caseworker_phone,
    :caseworker_organization,
    :details,
    :deadlines,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :submitted_at
  ].freeze

  # Overwrite this method to customize how assessments are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(assessment)
  #   "Assessment ##{assessment.id}"
  # end
end
