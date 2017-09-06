require "rails_helper"
require "feature_helper"

describe "assessment", js: true do
  let!(:root_node) do
    create(:node, root: true, tip: :county)
  end

  let!(:county_node) do
    create :node,
      parent_node_id: root_node.id,
      tip: :category,
      title: 'County',
      question: "Hello?"
  end

  let!(:category_node) do
    create :node,
      parent_node_id: county_node.id,
      icon: :housing,
      question: "Goodbye?",
      is_county: true,
      title: "FooBar"
  end

  let(:cross_check_input) do
    {
      details: "Some details",
      deadlines: 'deadlines',
      first_name: "Angela",
      last_name: "Smith",
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

  let!(:terminal_node_2) do
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
      markdown_content: "primary markdown content",
      markdown_content_es: "La contenta markdown primera"
  end

  let!(:node_referral) do
    create \
      :node_referral,
      node: terminal_node,
      referral: primary_referral
  end

  let!(:node_referral_2) do
    create \
      :node_referral,
      node: terminal_node_2,
      referral: primary_referral
  end

  let!(:secondary_referral) { create(:secondary_referral) }

  let!(:secondary_node_referral) do
    create(:node_referral, node: terminal_node, referral: secondary_referral)
  end

  let!(:special_referral) { create(:special_referral) }

  scenario "filling out all the optional screens" do
    visit root_path

    fill_up_to_cross_check
    start_cross_check

    step 'perform cross check' do
      click_square_and_next
      expect_page_to_have_progress_bar

      # details step
      expect(page).to have_content "give us additional details"
      fill_in "cross_check_details", with: cross_check_input[:details]
      expect(page).to have_content "do not include any client-identifying information"
      click_next
      expect_page_to_have_progress_bar

      # basic info step
      expect(page).to have_content "Please provide the following"
      expect_disabled_button
      fill_in_cross_check_info

      expect {
        click_next
      }.to change { ActionMailer::Base.deliveries.count }.by(1)

      expect_page_to_have_progress_bar

      # deadlines step
      expect(page).to have_content "any deadlines they need to meet"
      fill_in "cross_check_deadlines", with: cross_check_input[:deadlines]
      click_next
      expect_page_to_have_progress_bar

      # SF residency step
      expect(page).to have_content "live in FooBar County"
      click_square_and_next(index: 1)
      expect_page_to_have_progress_bar

      expect(page).to have_content "What county does your client"
      click_square_and_next
      expect_page_to_have_progress_bar

      # consulted attorney step
      expect(page).to have_content "consulted with an attorney"
      click_square_and_next
      expect_page_to_have_progress_bar

      expect(page).to have_content "have an attorney representing him/her"
      click_square_and_next
      expect_page_to_have_progress_bar

      # action items step
      expect(page).to have_content "actions that might help your client"
      click_next
    end

    view_assessment_page
  end

  scenario "hitting back on referral page should not duplicate the referrals" do
    visit root_path

    fill_in_assessment
    expect_to_have_referral_links(count: 2)

    page.driver.go_back

    click_square_and_next(node: terminal_node_2)
    expect_to_have_referral_links(count: 2)
  end

  scenario "filling out none of the optional screens" do
    visit root_path

    fill_up_to_cross_check
    start_cross_check

    step 'perform cross check' do
      click_square_and_next
      expect_page_to_have_progress_bar

      # details step
      expect(page).to have_content "give us additional details"
      fill_in "cross_check_details", with: cross_check_input[:details]
      expect(page).to have_content "do not include any client-identifying information"
      click_next
      expect_page_to_have_progress_bar

      # basic info step
      expect(page).to have_content "Please provide the following"
      expect_disabled_button
      fill_in_cross_check_info

      expect {
        click_next
      }.to change { ActionMailer::Base.deliveries.count }.by(1)

      expect_page_to_have_progress_bar

      # deadlines step
      expect(page).to have_content "any deadlines they need to meet"
      fill_in "cross_check_deadlines", with: cross_check_input[:deadlines]
      click_next
      expect_page_to_have_progress_bar

      # County residency step
      expect(page).to have_content "live in FooBar County"
      click_square_and_next
      expect_page_to_have_progress_bar

      # consulted attorney step
      expect(page).to have_content "consulted with an attorney"
      click_square_and_next(index: 1)
      expect_page_to_have_progress_bar

      # action items step
      expect(page).to have_content "actions that might help your client"
      click_next
    end

    view_assessment_page
  end

  def view_assessment_page
    step 'view assessment page' do
      expect(page).to have_content "Thank you, Angela!"

      [
        special_referral.title,
        primary_referral.title,
        secondary_referral.title,
        cross_check_input[:first_name],
        cross_check_input[:last_name],
        cross_check_input[:caseworker_phone],
        cross_check_input[:caseworker_email]
      ].each { |content| expect(page).to have_content content }
    end
  end

  def start_cross_check
    step 'begin cross check' do
      click_on "NEXT"
      expect(page).to have_content "Would you like a PLL Cross-Check?"
    end
  end

  def fill_up_to_cross_check
    fill_in_assessment
    view_primary_resource
  end

  def fill_in_cross_check_info
    fill_in "cross_check_first_name", with: cross_check_input[:first_name]
    fill_in "cross_check_last_name", with: cross_check_input[:last_name]
    fill_in "cross_check_caseworker_phone", with: cross_check_input[:caseworker_phone]
    fill_in "cross_check_caseworker_email", with: cross_check_input[:caseworker_email]
    select "Compass", from: "cross_check_caseworker_organization"
  end

  def view_primary_resource
    step 'view primary resource' do
      first(:link, "GET REFERRAL INFO").click
      expect(page).to have_content primary_referral.markdown_content

      # TODO: make this pass (it works in-app)
      # select "Spanish", from: "primary_referral_code" # :-(
      # expect(page).to have_content primary_referral.markdown_content_es

      click_on "BACK TO REFERRALS"
      expect(page).to have_content "Here are referrals that may help"
    end
  end

  def expect_to_have_referral_links(count:)
    expect(all(:link, "GET REFERRAL INFO").size).to eq(count)
  end

  def fill_in_assessment
    step "agree to initial requirements" do
      create_initial_assessment
    end

    step "select county node" do
      path = current_path
      expect_disabled_button
      expect_to_have_tips(text: "select the county that the case is in")

      expect(page).to have_content county_node.question

      click_square_title_and_next('County')
      expect_page_to_have_progress_bar

      expect(current_path).to_not eq path
    end

    step "select category node" do
      expect(page).to have_content category_node.question
      expect(page).to have_css('.square__icon')
      expect_to_have_tips(text: " learn more about the following categories")

      click_square_title_and_next('FooBar')
      expect_page_to_have_progress_bar
    end

    step 'select terminal node and view primary referrals page' do
      expect(page).to have_content terminal_node.question

      click_square_and_next(node: terminal_node)
      expect_page_to_have_progress_bar

      expect(page).to have_content "Here are referrals that may help"
      expect(page).to have_content primary_referral.title
      expect(page).to have_content primary_referral.unique_identifier
      expect(page).to have_content primary_referral.description
      expect(page).to have_content secondary_referral.title
    end
  end

  def expect_to_have_tips(**options)
    expect(page).to have_css ".tips", options
  end

  def expect_disabled_button
    expect(page).to have_css ".button--disabled"
  end

  def click_square_and_next(index: 0, node: nil)
    element =
      if node
        find(".square", text: node.title)
      else
        all(".square")[index]
      end

    element.click
    click_next
  end

  def click_next
    find(".button--submit").click
  end

  def expect_page_to_have_progress_bar
    expect(page).to have_css(".progress-bar")
  end

  def click_for(for_value)
    find("label[for=#{for_value}]").click
  end
end
