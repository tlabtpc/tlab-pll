require 'rails_helper'

describe NodesController do
  describe 'show' do
    let(:node) { create :node, title: "County" }
    let(:primary_referral) { create :primary_referral, terminal_node: terminal_node }
    let(:terminal_node) { create :node, terminal: true }
    let(:node_referral) { create :node_referral, node: terminal_node, referral: primary_referral}
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

    context "when the user has selected a special referral on the intro page" do
      let(:special_referral) {create(:special_referral)}
      before do
        assessment.referrals << special_referral
      end
      context "and the assessment path results in no primary or secondary referrals" do
        before do
          assessment.nodes << create(:node, no_referrals: true, parent_node: node)
        end
        it "they are not shown a tooltip that says they will go to cross-check next" do
          get :show, params: { id: node.id, assessment: assessment.token }

          expect(assigns[:special_referrals_exist]).to be true
        end
      end
    end
  end
end
