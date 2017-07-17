require "rails_helper"

describe "assessment", js: true do
  let!(:root_node) { create(:node, root: true, tip: :county) }
  let!(:county_node) { create(:node, parent_node_id: root_node.id, tip: :category, question: "Hello?") }
  let!(:category_node) { create(:node, parent_node_id: county_node.id, question: "Goodbye?") }

  let(:cross_check_input) do
    {
      details: "Some details",
      deadlines: 'deadlines',
      caseworker_name: "Angela Smith",
      caseworker_phone: "555-555-5555",
      caseworker_email: "angela@smith.com"
    }
  end

  let!(:terminal_node) do
    create \
      :node,
      terminal: true,
      parent_node_id: category_node.id,
      question: 'terminating?'
  end

  let!(:primary_referral) do
    create \
      :primary_referral,
      title: "Primary referral title",
      unique_identifier: "If your client needs housing:",
      description: "Primary referral description",
      markdown_content: "primary markdown content"
  end

  let!(:node_referral) do
    create \
      :node_referral,
      node: terminal_node,
      referral: primary_referral
  end

  let!(:secondary_referral) { create(:secondary_referral) }
  let!(:secondary_node_referral) { create(:node_referral, node: terminal_node, referral: secondary_referral) }
  let!(:special_referral) { create(:special_referral) }

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

      expect(page).to have_content county_node.question

      click_square_and_next

      expect(current_path).to_not eq path
    end

    step "select category node" do
      expect(page).to have_content category_node.question

      click_square_and_next
    end

    step 'select terminal node and view primary referrals page' do
      expect(page).to have_content terminal_node.question

      click_square_and_next

      expect(page).to have_content "Here are referrals that may help"
      expect(page).to have_content primary_referral.title
      expect(page).to have_content primary_referral.unique_identifier
      expect(page).to have_content primary_referral.description
      expect(page).to have_content secondary_referral.title
    end

    step 'view primary resource' do
      first(:link, "GET REFERRAL INFO").click
      expect(page).to have_content primary_referral.markdown_content

      click_on "BACK"
      expect(page).to have_content "Here are referrals that may help"
    end

    step 'begin cross check' do
      click_on "NEXT"
      expect(page).to have_content "Would you like a PLL Cross-Check?"
    end

    step 'perform cross check' do
      click_square_and_next

      # details step
      expect(page).to have_content "give us additional details"
      fill_in "cross_check_details", with: cross_check_input[:details]
      expect(page).to have_content "do not include any client-identifying information"
      click_next

      # basic info step
      expect(page).to have_content "Please provide the following"
      fill_in "cross_check_caseworker_name", with: cross_check_input[:caseworker_name]
      fill_in "cross_check_caseworker_phone", with: cross_check_input[:caseworker_phone]
      fill_in "cross_check_caseworker_email", with: cross_check_input[:caseworker_email]
      click_next

      # deadlines step
      expect(page).to have_content "any deadlines they need to meet"
      fill_in "cross_check_deadlines", with: cross_check_input[:deadlines]
      click_next

      # SF residency step
      expect(page).to have_content "reside in San Francisco County"
      click_square_and_next

      # consulted attorney step
      expect(page).to have_content "consulted with an attorney"
      click_square_and_next

      # action items step
      expect(page).to have_content "actions that might help your client"
      # TODO: do action items
      click_next

      # support level step
      expect(page).to have_content "What level of support do you think you will need"
      click_square_and_next
    end

    step 'view assessment page' do
      expect(page).to have_content "Yay, you're done!"

      [
        special_referral,
        root_node,
        county_node,
        category_node,
        primary_referral,
        secondary_referral
      ].each do |content|
        expect(page).to have_content content.title
      end

      # TODO: add cross check info to assessment page and ensure that it shows up correctly
    end
  end

  def click_square_and_next
    first(".square").click
    click_next
  end

  def click_next
    find(".button--submit").click
  end

  def click_for(for_value)
    find("label[for=#{for_value}]").click
  end
end
