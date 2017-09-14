class Views::Admin::CrossChecks::Unprocessed < Views::Base
  needs :page
  needs :resources
  needs :show_search_bar
  needs :search_term

  def content
    content_for(:title) { "Unprocessed " + display_resource_name(page.resource_name) }
    content_for(:search) do
      if show_search_bar
        render "search", search_term: search_term
      end
    end

    header(class: "main-content__header", role: :banner) do
      h1(content_for(:title), class: "main-content__page-title", id: "page-title")

      div do
        link_to(
          "Show all cross checks",
          [namespace, "#{page.resource_path}s"],
          class: "button",
        )
      end
      div do
        link_to(
          "#{t("administrate.actions.export")}",
          [:export, namespace, "#{page.resource_path}s", {scope: :unprocessed}],
          class: "button",
        ) if valid_action? :export
      end
    end

    section class: "main-content__body main-content__body--flush" do
      render "collection", collection_presenter: page, resources: resources.unprocessed
      paginate resources.unprocessed
    end
  end

end
