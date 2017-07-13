require 'rails_helper'

describe AssessmentReferralsController do
  let(:primary_referral) do
    create \
      :primary_referral,
      markdown_content: "# Header",
      terminal_node: terminal_node
  end
  let(:terminal_node) { create :node, terminal: true }
  let(:assessment) { create :assessment }

  describe 'index' do
    before { cookies[:assessment] = assessment.token }

    it 'displays referrals if they exist' do
      assessment.primary_referrals << primary_referral
      get :index
      expect(response).to render_template 'assessment_referrals/index'
      expect(assigns(:assessment)).to eq assessment
    end

  end

end
