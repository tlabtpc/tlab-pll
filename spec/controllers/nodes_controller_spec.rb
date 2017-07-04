require 'rails_helper'

describe NodesController do
  describe 'show' do
    let(:node) { create :node }
    let(:assessment) { create :assessment }

    it 'shows a node' do
      cookies[:assessment] = assessment.token
      get :show, params: { id: node.id }
      expect(response).to render_template 'nodes/show'
      expect(assigns[:node]).to eq node
    end

    it 'shows a node with assessment as a query param' do
      get :show, params: { id: node.id, assessment: assessment.token }
      expect(response).to render_template 'nodes/show'
      expect(assigns[:node]).to eq node
    end

    it 'redirects to new assessment if assessment is not found' do

    end
  end
end
