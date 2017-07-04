class DevController < ActionController::Base
  before_action :require_development_env

  def index
    @routes = self.class.action_methods.select { |action| /^(test_|setup_)/.match action }
    render 'dev/index', layout: false
  end

  def test_assessment_flow
    redirect_to setup_node_tree
  end

  private

  def require_development_env
    raise "Must be in development mode" unless Rails.env.development?
  end

  def setup_node_tree
    Node.create(title: Node::INITIAL_NODE_TITLE).tap do |root|
      Node.create(title: "Question A", parent_node_id: root.id).tap do |a|
        Node.create(title: "Question A -> C", parent_node_id: a.id,  terminal: true)
        Node.create(title: "Question A -> D", parent_node_id: a.id,  terminal: true)
      end

      Node.create(title: "Question B", parent_node_id: root.id).tap do |b|
        Node.create(title: "Question B -> C", parent_node_id: b.id,  terminal: true)
        Node.create(title: "Question B -> D", parent_node_id: b.id,  terminal: true)
      end
    end
  end
end
