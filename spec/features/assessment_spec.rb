require "rails_helper"

describe "assessment", js: true do
  let!(:special_referral) { create(:special_referral) }
  let!(:root_node) { create(:node, root: true, tip: :county) }
  let!(:county_node) { create(:node, parent_node_id: root_node.id, tip: :category, question: "Hello?") }
  let!(:category_node) { create(:node, parent_node_id: county_node.id, question: "Goodbye?") }

  specify do
    visit root_path

    step "agree to initial requirements" do
      click_for "agree_schedule"
      click_for "agree_paperwork"

      expect(page).to_not have_css ".assessments__special-referrals"
      click_for "agree_legal"

      expect(page).to have_css ".assessments__special-referrals"

      click_for "referral_id_#{special_referral.id}"

      click_for "assessment_submit"
      expect(page).to have_css "body.nodes-show"
    end

    step "select county node" do
      path = current_path
      expect(page).to have_css ".button--submit[disabled]"
      expect(page).to have_css ".tips"

      find(".nodes__child-list-item").click
      find(".button--submit").click

      expect(current_path).to_not eq path
      expect(page).to have_content county_node.question
    end

    step "select category node" do
      find(".nodes__child-list-item").click
      find(".button--submit").click
      expect(page).to have_content category_node.question
    end
  end

  def click_for(for_value)
    find("label[for=#{for_value}]").click
  end
end
