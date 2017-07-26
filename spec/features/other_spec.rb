require "rails_helper"
require "feature_helper"

describe "straight to cross check", js: true do
  before do
    suppress_output {
      load Rails.root + "db/seeds.rb"
    }
  end

  specify do
    visit root_path

    step "agree to initial requirements" do
      create_initial_assessment(choose_special: false)
    end

    step "select other benefits node" do
      click_square_title_and_next('San Mateo')
      click_square_title_and_next('Benefits')
      click_square_title_and_next('Other')
      expect(page).to have_content "give us additional details"

      click_back
      expect(page).to have_content "What type of benefit does your client's question relate to?"
    end
  end
end
