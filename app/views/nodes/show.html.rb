class Views::Nodes::Show < Views::Base
  needs :node
  needs :assessment

  def content
    row do
      columns do
        h1 "Welcome to your new assessment!"

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
end
