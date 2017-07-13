require "rails_helper"

describe "assessment", js: true do
  let!(:special_referral) { create(:special_referral) }
  let!(:root_node) { create(:node, root: true, tip: :county) }
  let!(:county_node) { create(:node, parent_node_id: root_node.id, tip: :category, question: "Hello?") }
  let!(:category_node) { create(:node, parent_node_id: county_node.id, question: "Goodbye?") }

  let!(:terminal_node) do
    create \
      :node,
      terminal: true,
      parent_node_id: category_node.id,
      question: 'terminating?'
  end

  let!(:primary_referral) { create :primary_referral, terminal_node: terminal_node }

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

      click_square_and_submit

      expect(current_path).to_not eq path
      expect(page).to have_content county_node.question
    end

    step "select category node" do
      click_square_and_submit
      expect(page).to have_content category_node.question
    end

    step 'select terminal node' do
      click_square_and_submit
      expect(page).to have_content 'Nodes selected:'

      [
        special_referral,
        root_node,
        county_node,
        category_node,
        primary_referral
      ].each do |node|
        expect(page).to have_content node.title
      end
    end
  end

  def click_square_and_submit
    find(".square").click
    find(".button--submit").click
  end

  def click_for(for_value)
    find("label[for=#{for_value}]").click
  end
end
