require "rails_helper"

describe "assessment", js: true do
  before do
    suppress_output {
      load Rails.root + "db/seeds.rb"
    }
  end

  specify do
    visit root_path

    step "agree to initial requirements" do
      click_for "agree_schedule"
      click_for "agree_paperwork"

      expect(page).to_not have_css ".assessments__special-referrals"
      click_for "agree_legal"

      expect(page).to have_css ".assessments__special-referrals"

      click_for "assessment_submit"
      expect(page).to have_css "body.nodes-show"
    end

    step "select alameda county node" do
      expect(page).to have_css ".button--submit[disabled]"
      expect(page).to have_css ".tips"

      expect(page).to have_content "What county is the issue in?"

      click_square_and_next "Alameda"
      click_next

      expect(page).to have_content "Can you tell which category of legal help your client needs?"
    end

    step "select benefits node" do
      click_square_and_next "Benefits"
      click_next

      expect(page).to have_content "What type of benefit does your client's question relate to?"
      expect(page).to have_content "Non-citizen benefits"
    end
  end

  def click_square_and_next(text)
    find("li", :text => text).click
    click_next
  end

  def click_next
    find(".button--submit").click
  end

  def click_for(for_value)
    find("label[for=#{for_value}]").click
  end
end

