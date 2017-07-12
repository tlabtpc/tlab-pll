require 'rails_helper'

describe PrimaryReferralsController do
  describe 'show' do
    let!(:primary_referral) { create :primary_referral, markdown_content: "#Header", terminal_node_id: "1" }

    it 'shows a referral with markdown' do
      get :show, params: { id: primary_referral.id }
      expect(response).to render_template 'primary_referrals/show'
      expect(assigns[:primary_referral]).to eq primary_referral
      expect(response.body).to include("<h1>Header</h1>")
    end

  end
end
