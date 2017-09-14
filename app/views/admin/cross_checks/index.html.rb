# # Index
#
# This view is the template for the index page.
# It is responsible for rendering the search bar, header and pagination.
# It renders the `_table` partial to display details about the resources.
#
# ## Local variables:
#
# - `page`:
#   An instance of [Administrate::Page::Collection][1].
#   Contains helper methods to help display a table,
#   and knows which attributes should be displayed in the resource's table.
# - `resources`:
#   An instance of `ActiveRecord::Relation` containing the resources
#   that match the user's search criteria.
#   By default, these resources are passed to the table partial to be displayed.
# - `search_term`:
#   A string containing the term the user has searched for, if any.
# - `show_search_bar`:
#   A boolean that determines if the search bar should be shown.
#
# [1]: http://www.rubydoc.info/gems/administrate/Administrate/Page/Collection
# %>

class Views::Admin::CrossChecks::Index < Views::Base
  needs :page
  needs :resources
  needs :show_search_bar
  needs :search_term

  def content
    content_for(:title) { display_resource_name(page.resource_name) }
    content_for(:search) do
      if show_search_bar
        render "search", search_term: search_term
      end
    end

    header(class: "main-content__header", role: :banner) do
      h1(content_for(:title), class: "main-content__page-title", id: "page-title")

      div do
        link_to(
          "Show unprocessed cross checks",
          [:unprocessed, namespace, "#{page.resource_path}s"],
          class: "button",
        )
      end
      div do
        link_to(
          "#{t("administrate.actions.export")}",
          [:export, namespace, "#{page.resource_path}s", {scope: :all}],
          class: "button",
        ) if valid_action? :export
      end
    end

    section class: "main-content__body main-content__body--flush" do
      render "collection", collection_presenter: page, resources: resources
      paginate resources
    end
  end
end
