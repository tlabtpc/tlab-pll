require 'rails_helper'

describe CrossChecksController do
  let!(:assessment) { create :assessment }
  let!(:cross_check) { create :cross_check, assessment: assessment }

  let(:cross_check_params) do
    {
      cross_check: { details: "Here are some details" }
    }
  end
  let(:start_params) do
    {
      cross_check: { perform_check: "1" }
    }
  end
  let(:action_params) do
    {
      cross_check: { action_items: ['one','two']}
    }
  end

  before do
    cookies[:assessment] = assessment.token
  end

  describe 'next_step' do
    it 'continues on if perform_check is true for start step' do
      post :next_step, params: start_params.merge(current_step: :start)
      expect(response).to redirect_to details_cross_checks_path
    end

    it 'redirects to the assessment show page if no cross check is wanted' do
      start_params[:cross_check][:perform_check] = "0"
      post :next_step, params: start_params.merge(current_step: :start)
      expect(response).to redirect_to assessment_path(assessment)
    end

    it 'saves data to the cross check' do
      post :next_step, params: cross_check_params.merge(current_step: :details)

      expect(cross_check.reload.details).to eq cross_check_params[:cross_check][:details]
      expect(response).to redirect_to info_cross_checks_path
    end

    it 'does not duplicate action items' do
      post :next_step, params: action_params.merge(current_step: :actions)
      expect(cross_check.reload.action_items.length).to eq action_params[:cross_check][:action_items].length
      expect(cross_check.action_items).to include action_params[:cross_check][:action_items].first
      post :next_step, params: action_params.merge(current_step: :actions)
      expect(cross_check.reload.action_items.length).to eq action_params[:cross_check][:action_items].length
    end
  end

  describe 'previous_step' do
    it 'does not save form values' do
      post :previous_step, params: {
        cross_check: cross_check_params,
        current_step: :info
      }

      expect(response).to redirect_to details_cross_checks_path
      expect(cross_check.reload.details).to_not eq cross_check_params[:cross_check][:details]
    end

    it 'goes back to the referrals page if on first step and referrals exist' do
      assessment.assessment_referrals.create(referral: create(:primary_referral))
      post :previous_step, params: { current_step: :start }

      expect(response).to redirect_to assessment_referrals_path
    end

    it 'goes back to selecting a terminal node if on first step and no referrals exist' do
      post :previous_step, params: { current_step: :start }

      expect(response).to redirect_to assessment_nodes_path
    end
  end

  describe 'edit_actions' do
    it 'renders the template for an edit action' do
      get :info

      expect(response).to render_template :info
      expect(assigns(:cross_check)).to eq cross_check
    end
  end
end
