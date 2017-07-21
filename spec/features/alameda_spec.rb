require "rails_helper"
require "feature_helper"

describe "assessment", js: true do
  before do
    suppress_output {
      load Rails.root + "db/seeds.rb"
    }
  end
  
  let!(:special_referral) { create(:special_referral, priority: 9) }

  specify do
    visit root_path

    step "agree to initial requirements" do
      create_initial_assessment
    end

    step "select alameda county node" do
      expect(page).to have_css ".button--submit[disabled]"
      expect(page).to have_css ".tips"

      expect(page).to have_content "What county is the issue in?"

      click_square_and_next(index: 0)
      click_next

      expect(page).to have_content "Can you tell which category of legal help your client needs?"
    end

    step "select benefits node" do
      click_square_and_next(index: 0)
      click_next

      expect(page).to have_content "What type of benefit does your client's question relate to?"
      expect(page).to have_content "Non-citizen benefits"
    end
  end
end
