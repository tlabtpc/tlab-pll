require "administrate/base_dashboard"

class PrimaryReferralDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    title: Field::String,
    id: Field::Number,
    priority: Field::Number,
    markdown_content: Field::Text,
    markdown_content_es: Field::Text,
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
    :title
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :title,
    :markdown_content,
    :markdown_content_es,
    :priority,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :markdown_content,
    :markdown_content_es,
    :priority
  ].freeze

  # Overwrite this method to customize how primary referrals are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(primary_referral)
    "##{primary_referral.id} - #{primary_referral.markdown_content}"
  end
end
