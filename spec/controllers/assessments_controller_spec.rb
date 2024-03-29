require 'rails_helper'

describe AssessmentsController do
  describe 'show' do
    let(:assessment) { create :assessment }

    it 'displays an assessment' do
      get :show, params: { id: assessment.id }
      expect(response).to render_template 'assessments/show'
      expect(assigns[:assessment]).to eq assessment
      expect(assessment.reload.submitted_at).to be_present
    end

    it 'does not updated submitted_at if it is already set' do
      assessment.update(submitted_at: 1.day.ago)
      expect { get :show, params: { id: assessment.id } }.to_not change { assessment.submitted_at }
    end

    it 'redirects to the home page if it cant find the assessment' do
      get :show, params: { id: :notanid }
      expect(response).to redirect_to root_path
    end
  end

  describe 'new' do
    it 'renders new' do
      get :new
      expect(response).to render_template 'assessments/new'
    end
  end

  describe 'create' do
    let!(:initial_node) { create(:node, root: true) }
    let(:referral) { create :special_referral }

    it 'creates a new assessment' do
      expect { post :create }.to change { Assessment.count }.by(1)
      expect(cookies[:assessment]).to eq Assessment.last.token
      expect(response).to redirect_to initial_node
    end

    it 'creates special referrals if they exist' do
      expect { post :create, params: {assessment: {referral_ids: [referral.id]}}}.to change { Assessment.count }.by(1)
      expect(Assessment.last.referrals).to include referral
    end
  end
end
