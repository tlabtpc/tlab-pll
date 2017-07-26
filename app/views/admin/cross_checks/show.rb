class Views::Admin::CrossChecks::Show < Views::Base
  needs :page

  def content
    content_for(:title) { "#{t("administrate.actions.show")} #{page.page_title}" }

    header class: "main-content__header", role: :banner do
      h1(content_for(:title), class: "main-content__page-title")

      div do
        link_to(
          "#{t("administrate.actions.export", title: page.page_title)}",
          [:export, namespace, page.resource],
          class: "button",
        ) if valid_action? :export
      end
    end

    section class: "main-content__body" do
      dl do
        page.attributes.each do |attribute|
          dt class: "attribute-label" do
            text t "helpers.label.#{resource_name}.#{attribute.name}", default: attribute.name.titleize
          end
          dd class: "attribute-data attribute-data--#{attribute.html_class}" do
            text render_field attribute
          end
        end
      end
    end
  end
end
