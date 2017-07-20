class Views::Nodes::Show < Views::Base
  needs :node
  needs :assessment

  START_PAGE_OFFSET = 2
  MAXIMUM_ASSESS_BAR_INDEX = 6

  def content
    set_progress_bar! index: [
      assessment.nodes.count + START_PAGE_OFFSET,
      MAXIMUM_ASSESS_BAR_INDEX
    ].min

    children = node.children
    children_question = children.first&.question
    content_for(:card) do
      p(children_question, class: "nodes__question") if children_question

      ul(class: "square-collection") do
        children.each do |child|
          render partial: "square", locals: {
            value: child.id,
            label: child.title,
            description: child.description,
            icon: child.icon
          }
        end
      end
    end

    content_for(:tip) do
      render_tip if node.tip.present?
    end

    content_for :back do
      link_to assessment_nodes_path, class: "button button--back", method: :delete do
        fa_icon 'arrow-left'
        span "Back"
      end
    end

    content_for :next do
      form_for :assessment_node, url: assessment_nodes_path do |f|
        f.text_field :node_id, type: :hidden, id: :square_value
        button_tag class: "button button--submit", type: :submit, disabled: true do
          span "Next"
          fa_icon 'arrow-right'
        end
      end
    end
  end

  def render_tip
    render "tips/#{node.tip}"
  rescue ActionView::MissingTemplate
    render "tips/not_found" if Rails.env.development?
  end
end
