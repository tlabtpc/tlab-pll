require 'rails_helper'

describe NodesController do
  describe 'show' do
    let(:node) { create :node }
    let(:primary_referral) { create :primary_referral, terminal_node: terminal_node }
    let(:terminal_node) { create :node, terminal: true }
    let(:assessment) { create :assessment }

    it 'shows a node' do
      cookies[:assessment] = assessment.token
      get :show, params: { id: node.id }

      expect(response).to render_template 'nodes/show'
      expect(assigns[:node]).to eq node
      expect(assigns[:assessment]).to eq assessment
    end

    it 'shows a node with assessment as a query param' do
      get :show, params: { id: node.id, assessment: assessment.token }

      expect(response).to render_template 'nodes/show'
      expect(assigns[:node]).to eq node
    end
  end
end
