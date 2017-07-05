require "administrate/base_dashboard"

class NodeDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    parent_node: Field::BelongsTo.with_options(class_name: "Node"),
    children: Field::HasMany.with_options(class_name: "Node"),
    referrals: Field::HasMany,
    id: Field::Number,
    parent_node_id: Field::Number,
    terminal: Field::Boolean,
    node_type: Field::String,
    is_category: Field::Boolean,
    is_county: Field::Boolean,
    title: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :parent_node,
    :children,
    :referrals,
    :id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :parent_node,
    :children,
    :referrals,
    :id,
    :parent_node_id,
    :terminal,
    :node_type,
    :is_category,
    :is_county,
    :title,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :parent_node,
    :children,
    :referrals,
    :parent_node_id,
    :terminal,
    :node_type,
    :is_category,
    :is_county,
    :title,
  ].freeze

  # Overwrite this method to customize how nodes are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(node)
  #   "Node ##{node.id}"
  # end
end
