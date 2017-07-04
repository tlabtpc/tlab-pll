class DevController < ActionController::Base
  before_action :require_development_env

  def index
    @routes = self.class.action_methods.select { |action| /^(test_|setup_)/.match action }
    render 'dev/index', layout: false
  end

  def test_assessment_flow
    cookies[:assessment] = Assessment.create.token
    redirect_to setup_node_tree
  end

  private

  def require_development_env
    raise "Must be in development mode" unless Rails.env.development?
  end

  def setup_node_tree
    Node.create(title: "Initial Node", root: true).tap do |root|
      Node.create(title: "Node A", parent_node_id: root.id).tap do |a|
        Node.create(title: "Node A1", parent_node_id: a.id,  terminal: true).tap do |a1|
          a1.referrals.push(Referral.create(type: "PrimaryReferral", title: "Referral A1"))
        end
        Node.create(title: "Node A2", parent_node_id: a.id,  terminal: true).tap do |a2|
          a2.referrals.push(Referral.create(type: "PrimaryReferral", title: "Referral A2"))
        end
      end

      Node.create(title: "Node B", parent_node_id: root.id).tap do |b|
        Node.create(title: "Node B1", parent_node_id: b.id,  terminal: true).tap do |b1|
          b1.referrals.push(Referral.create(type: "PrimaryReferral", title: "Referral B1"))
        end
        Node.create(title: "Node B2", parent_node_id: b.id,  terminal: true).tap do |b2|
          b2.referrals.push(Referral.create(type: "PrimaryReferral", title: "Referral B2"))
        end
      end
    end
  end
end
