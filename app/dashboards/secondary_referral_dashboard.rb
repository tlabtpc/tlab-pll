require "administrate/base_dashboard"

class SecondaryReferralDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    terminal_node: Field::BelongsTo.with_options(class_name: "Node"),
    id: Field::Number,
    type: Field::String,
    title: Field::String,
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
    :link,
  ].freeze

  # Overwrite this method to customize how secondary referrals are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(secondary_referral)
    "##{secondary_referral.id} - #{secondary_referral.title}"
  end
end