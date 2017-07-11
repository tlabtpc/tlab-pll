require "rails_helper"

describe "assessment", js: true do
  let!(:special_referral) { create(:special_referral) }

  specify do
    visit root_path

    step "agree to initial requirements" do
      click_for "confirm_schedule"
      click_for "confirm_paperwork"

      expect(page).to_not have_css ".assessments__special-referrals"
      click_for "confirm_legal"

      expect(page).to have_css ".assessments__special-referrals"

      click_for "referral_id_#{special_referral.id}"

      click_for "assessment_submit"
    end

    step "select county node" do
    end

    step "select category node" do
    end
  end

  def click_for(for_value)
    find("label[for=#{for_value}]").click
  end
end
