class Views::Layouts::Nodes < Views::Layouts::Application
  needs :node

  def content
    content_for(:sidebar) do
      if node.tip.present?
        div(class: "columns small-12 medium-7") { yield }
        div(class: "columns small-12 medium-4 large-3") { div(class: :tips) { render_tip } }
        div(class: "columns small-0 medium-1 large-2")
      else
        yield
      end
    end

    content_for(:footer) do
      div(class: "nodes__footer") do
        # back button
        link_to assessment_nodes_path, method: :delete do
          i class: "fa fa-arrow-left"
          span "Back"
        end

        # next button
        form_for :assessment_node, url: assessment_nodes_path do |f|
          f.text_field :node_id, type: :hidden, id: "node_id"
          button_tag class: "button nodes__submit-button", type: :submit, disabled: true do
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
