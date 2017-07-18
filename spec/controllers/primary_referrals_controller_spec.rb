require 'rails_helper'

describe PrimaryReferralsController do
  let(:primary_referral) do
    create \
      :primary_referral,
      markdown_content: "# Header"
  end
  let(:terminal_node) { create :node, terminal: true }
  let(:node_referral) { create :node_referral, node: terminal_node, referral: primary_referral}
  let(:assessment) { create :assessment }
  let(:email_params) do
    {
      email_address: "test@example.com"
    }
  end

  describe 'show' do
    it 'shows a referral with markdown' do
      get :show, params: { id: primary_referral.id }

      expect(response).to render_template 'primary_referrals/show'
      expect(assigns[:primary_referral]).to eq primary_referral
      expect(response.body).to include("<h1>Header</h1>")
    end
  end

  describe 'send_email' do
    it 'sends an email' do
      expect {
        post :send_email, params: { id: primary_referral.id, primary_referral: email_params }
      }.to change { ActionMailer::Base.deliveries.count }.by(1)

      expect(ActionMailer::Base.deliveries.last.to).to include "test@example.com"
      expect(flash[:info]).to be_present
      expect(response).to redirect_to primary_referral_path(primary_referral)
    end

    it 'does not send an email if one is not provided' do
      expect {
        post :send_email, params: { id: primary_referral.id, primary_referral: {} }
      }.to_not change { ActionMailer::Base.deliveries.count }
      expect(flash[:error]).to be_present
      expect(response).to redirect_to primary_referral_path(primary_referral)
    end
  end
end
