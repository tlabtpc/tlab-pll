require "administrate/base_dashboard"

class PrimaryReferralDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    terminal_node: Field::BelongsTo.with_options(class_name: "Node"),
    id: Field::Number,
    title: Field::String,
    description: Field::Text,
    introduction: Field::String,
    link: Field::String,
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
    :link
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :terminal_node,
    :id,
    :title,
    :description,
    :introduction,
    :link,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :terminal_node,
    :title,
    :description,
    :introduction,
    :link,
  ].freeze

  # Overwrite this method to customize how primary referrals are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(primary_referral)
    "##{primary_referral.id} - #{primary_referral.title}"
  end
end
