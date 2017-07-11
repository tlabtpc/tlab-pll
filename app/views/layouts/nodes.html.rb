class Views::Layouts::Nodes < Views::Layouts::Application
  needs :node

  def content
    content_for(:sidebar) do
      div(class: :tips) { render_tip } if node.tip.present?
    end

    content_for(:footer) do
      div class: "nodes__footer-flash", id: "node_description"
      div(class: "nodes__footer") do
        # back button
        link_to assessment_nodes_path, class: "button secondary", method: :delete do
          i class: "fa fa-arrow-left"
          span "Back"
        end

        # next button
        form_for :assessment_node, url: assessment_nodes_path do |f|
          f.text_field :node_id, type: :hidden, id: "node_id"
          button_tag class: "button button--green nodes__submit-button", type: :submit, disabled: true do
            span "Next"
            i class: "fa fa-arrow-right"
          end
        end

        # spacer for flexbox
        div
      end
    end
    super
  end

  def render_tip
    render "tips/#{node.tip}"
  rescue ActionView::MissingTemplate
    render "tips/not_found" if Rails.env.development?
  end
end
