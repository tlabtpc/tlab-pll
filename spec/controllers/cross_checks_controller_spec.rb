require 'rails_helper'

describe CrossChecksController do
  let(:assessment) { create :assessment }
  let(:cross_check) { create :cross_check, assessment: assessment }
  let(:previous_assessment) { create :assessment }
  let!(:previous_cross_check) { create :cross_check, assessment: previous_assessment, first_name: "Bob", last_name: "Dole", caseworker_email: "bob@dole.gov" }


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
    it 'fetches previous assessment info' do
      cookies[:previous_assessment] = previous_assessment.token
      post :next_step, params: start_params.merge(current_step: :start)
      cc = assessment.cross_check
      expect(cc.first_name).to eq previous_cross_check.first_name
      expect(cc.last_name).to eq previous_cross_check.last_name
      expect(cc.caseworker_email).to eq previous_cross_check.caseworker_email
    end

    it 'deletes previous assessment info' do
      cookies[:previous_assessment] = previous_assessment.token
      post :next_step, params: cross_check_params.merge(remember_my_info: "0")
      expect(cookies[:previous_assessment]).to be_nil
    end

    it 'stores info if remember_my_info is set' do
      cross_check
      cross_check_params[:cross_check][:remember_my_info] = true
      post :next_step, params: cross_check_params
      expect(cookies[:previous_assessment]).to eq assessment.token
    end

    it 'continues on if perform_check is true for start step' do
      cross_check
      post :next_step, params: start_params.merge(current_step: :start)
      expect(response).to redirect_to details_cross_checks_path
    end

    it 'redirects to the assessment show page if no cross check is wanted' do
      cross_check
      start_params[:cross_check][:perform_check] = "0"
      post :next_step, params: start_params.merge(current_step: :start)
      expect(response).to redirect_to assessment_path(assessment.id)
    end

    it 'saves data to the cross check' do
      cross_check
      post :next_step, params: cross_check_params.merge(current_step: :details)

      expect(cross_check.reload.details).to eq cross_check_params[:cross_check][:details]
      expect(response).to redirect_to info_cross_checks_path
    end

    it 'does not duplicate action items' do
      cross_check
      post :next_step, params: action_params.merge(current_step: :actions)
      expect(cross_check.reload.action_items.length).to eq action_params[:cross_check][:action_items].length
      expect(cross_check.action_items).to include action_params[:cross_check][:action_items].first
      post :next_step, params: action_params.merge(current_step: :actions)
      expect(cross_check.reload.action_items.length).to eq action_params[:cross_check][:action_items].length
    end
  end

  describe 'previous_step' do
    it 'does not save form values' do
      cross_check
      post :previous_step, params: {
        cross_check: cross_check_params,
        current_step: :info
      }

      expect(response).to redirect_to details_cross_checks_path
      expect(cross_check.reload.details).to_not eq cross_check_params[:cross_check][:details]
    end
  end

  describe 'edit_actions' do
    it 'renders the template for an edit action' do
      cross_check
      get :info

      expect(response).to render_template :info
      expect(assigns(:cross_check)).to eq cross_check
    end
  end
end
