require 'rails_helper'

describe AssessmentsController do
  describe 'new' do
    it 'renders new' do
      get :new
      expect(response).to render_template 'assessments/new'
    end
  end

  describe 'create' do
    let!(:initial_node) { create(:node, title: Node::INITIAL_NODE_TITLE) }

    it 'creates a new assessment' do
      expect { post :create }.to change { Assessment.count }.by(1)
      expect(cookies[:assessment]).to eq Assessment.last.token
      expect(response).to redirect_to initial_node
    end
  end
end
