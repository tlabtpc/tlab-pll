class Views::Nodes::Show < Views::Base
  needs :node
  needs :assessment

  def content
    content_for(:card) do
      p(node.question, class: "nodes__question") if node.question

      ul(class: "nodes__child-list") do
        node.children.each do |child|
          li(child.title, class: "nodes__child-list-item", data: {
            id: child.id,
            description: child.description
          })
        end
      end
    end
  end
end
