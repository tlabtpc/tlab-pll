require 'rails_helper'

describe AssessmentNodesController do
  describe 'create' do
    let(:node) { create :node, parent_node_id: parent_node.id }
    let(:parent_node) { create :node }
    let(:assessment) { create :assessment }
    before { cookies[:assessment] = assessment.token }

    it 'creates an assessment node given a node id' do
      expect { post :create, params: { assessment_node: { node_id: node.id} } }.to change { AssessmentNode.count }.by(1)
      an = AssessmentNode.last
      expect(an.assessment).to eq assessment
      expect(an.node).to eq node.parent_node
      expect(response).to redirect_to node
    end
  end
end
