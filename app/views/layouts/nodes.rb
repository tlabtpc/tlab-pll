class Views::Layouts::Nodes < Views::Layouts::Application
  needs :node

  def content
    content_for :node do
      if node.tip.present?
        div(class: "columns small-12 medium-7") { yield }
        div(class: "columns small-12 medium-4 large-3") { div(class: :tips) { render_tip } }
        div(class: "columns small-0 medium-1 large-2")
      else
        yield
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
