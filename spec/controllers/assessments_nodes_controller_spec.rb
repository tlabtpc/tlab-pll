require 'rails_helper'

describe AssessmentNodesController do
  let!(:node) { create :node, parent_node_id: parent_node.id }
  let!(:parent_node) { create :node }
  let!(:assessment) { create :assessment }

  before do
    cookies[:assessment] = assessment.token
  end

  describe 'create' do
    it 'creates an assessment node given a node id' do
      expect do
        post :create, params: { assessment_node: { node_id: node.id} }
      end.to change { AssessmentNode.count }.by(1)

      an = AssessmentNode.last
      expect(an.assessment).to eq assessment
      expect(an.node).to eq node.parent_node
      expect(response).to redirect_to node
    end

    it 'does not add duplicate nodes to an assessment' do
      expect do
        post :create, params: { assessment_node: { node_id: node.id} }
      end.to change { AssessmentNode.count }.by(1)

      expect do
        post :create, params: { assessment_node: { node_id: node.id} }
      end.to_not change { AssessmentNode.count }
    end

    context 'node is terminal' do
      let!(:referral) { create(:primary_referral) }
      let!(:terminal_node) { create :node, terminal: true }

      before do
        terminal_node.referrals << referral
      end

      it "adds the node's referrals to the assessment" do
        post :create, params: { assessment_node: { node_id: terminal_node.id} }

        expect(assessment.referrals).to eq terminal_node.referrals
      end

      it "add's the node to the assessment" do
        post :create, params: { assessment_node: { node_id: terminal_node.id} }

        expect(assessment.nodes).to include terminal_node
      end

      context "node has already been added to assessment" do
        it 'does not add its referrals again' do
          post :create, params: { assessment_node: { node_id: terminal_node.id} }
          post :create, params: { assessment_node: { node_id: terminal_node.id} }

          expect(assessment.referrals.count).to eq 1
          expect(assessment.referrals).to eq terminal_node.referrals
        end
      end
    end
  end

  describe 'destroy' do
    let(:assessment_node) { assessment.assessment_nodes.create(node: node) }

    it 'returns to the last stored node if one exists' do
      assessment_node
      expect { delete :destroy }.to change { assessment.nodes.count }.by(-1)
      expect(response).to redirect_to node_path(node)
    end

    it 'destroys the assessment and redirects to a new one if no nodes exist' do
      expect { delete :destroy }.to change { Assessment.count }.by(-1)
      expect(response).to redirect_to new_assessment_path
    end
  end
end
