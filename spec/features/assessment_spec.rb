require "rails_helper"

describe "assessment", js: true do
  let(:special_referral) { create(:special_referral) }

  specify do
    visit root_path
    puts page.html

    step "agree to initial requirements" do
      find(:xpath, '//label[for=confirm_schedule]').click
      select "#confirm_paperwork"

      expect(page).to_not have_css ".assessments__special-referrals"
      select "#confirm_legal"

      expect(page).to have_css ".assessments__special-referrals"

      select "#referral_id_#{special_referral.id}"

      click_button "Next"
    end
  end
end
