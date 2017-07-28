require 'rails_helper'
require 'feature_helper'

describe 'useful referrals', js: true do
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
      markdown_content: "primary markdown content",
      markdown_content_es: "La contenta markdown primera"
  end

  let!(:node_referral) do
    create \
      :node_referral,
      node: terminal_node,
      referral: primary_referral
  end

  scenario 'marking referrals as useful' do
    fill_in_up_to_referrals

    expect(page).to have_content 'Is this referral useful?'
    find_all(".assessment-referrals__referral-usefulness-button").first.click

    find_all(".button--submit").last.click

    expect(page).to have_content('Would you like a PLL Cross-Check?')
    expect(AssessmentReferral.last).to be_useful
  end

  def fill_in_up_to_referrals
    visit root_path

    create_initial_assessment(choose_special: false)
    expect(page).to have_content county_node.question

    click_square_title_and_next('County')
    click_square_title_and_next('FooBar')
    click_square_and_next(node: terminal_node)
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
end
