require 'rails_helper'

describe CrossChecksController do
  let!(:assessment) { create :assessment }
  let!(:cross_check) { create :cross_check, assessment: assessment }
  let(:cross_check_params) {{
    cross_check: { details: "Here are some details" }
  }}
  before { cookies[:assessment] = assessment.token }

  describe 'next_step' do
    it 'saves data to the cross check' do
      post :next_step, params: { cross_check: cross_check_params, current_step: :details }
      expect(cross_check.details).to eq cross_check_params[:details]
      expect(response).to redirect_to info_cross_checks_path
    end
  end

  describe 'previous_step' do
    it 'does not save form values' do
      post :previous_step, params: { cross_check: cross_check_params, current_step: :info }
      expect(response).to redirect_to details_cross_checks_path
      expect(cross_check.reload.details).to_not eq cross_check_params[:details]
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
