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
      div class: "nodes__footer-flash", id: "node_description"
      div class: "nodes__next-form" do
        form_for :assessment_node, url: assessment_nodes_path do |f|
          f.text_field :node_id, type: :hidden, id: "node_id"
          button_tag class: :button, type: :submit do
            span "Next"
            i class: "fa fa-arrow-right"
          end
        end
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
