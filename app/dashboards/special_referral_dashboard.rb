require "administrate/base_dashboard"
include ApplicationHelper

class SpecialReferralDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    unique_identifier: Field::String,
    title: Field::String,
    description: Field::Text,
    markdown_content: Field::Text,
    markdown_content_es: Field::Text,
    has_markdown?: Field::Boolean,
    has_markdown_es?: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :title,
    :has_markdown?,
    :has_markdown_es?
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :title,
    :unique_identifier,
    :description,
    :markdown_content,
    :markdown_content_es,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :unique_identifier,
    :title,
    :description,
    :markdown_content,
    :markdown_content_es
  ].freeze

  # Overwrite this method to customize how primary referrals are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(primary_referral)
    primary_referral.title
  end
end
