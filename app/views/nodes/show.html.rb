class Views::Nodes::Show < Views::Base
  needs :node
  needs :assessment

  def content
    row do
      columns do
        h1 "Welcome to your new assessment!"

        ul do
          node.children.each do |child|
            form_for :assessment_node, url: assessment_nodes_path do |f|
              f.text_field :node_id, type: :hidden, value: child.id
              f.submit child.title
            end
          end
        end
      end
    end
  end
end
