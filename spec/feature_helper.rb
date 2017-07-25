def create_initial_assessment(choose_special: true)
  click_for "agree_schedule"
  click_for "agree_paperwork"

  expect(page).to_not have_css ".assessments__special-referrals"
  click_for "agree_legal"

  if choose_special
    expect(page).to have_css ".assessments__special-referrals"
    click_for "referral_id_#{special_referral.id}"
  end

  click_for "assessment_submit"

  expect(page).to have_css "body.nodes-show"
  expect_page_to_have_progress_bar
end

def fill_in_cross_check_info
  fill_in "cross_check_first_name", with: cross_check_input[:first_name]
  fill_in "cross_check_last_name", with: cross_check_input[:last_name]
  fill_in "cross_check_caseworker_phone", with: cross_check_input[:caseworker_phone]
  fill_in "cross_check_caseworker_email", with: cross_check_input[:caseworker_email]
  select "Compass Family Services", from: "cross_check_caseworker_organization"
end

def expect_to_have_tips(**options)
  expect(page).to have_css ".tips", options
end

def expect_disabled_button
  expect(page).to have_css ".button--disabled"
end

def click_square_and_next(index: 0)
  click_square(index: index)
  click_next
end

def click_square(index: 0)
  all(".square")[index].click
end

def click_next
  find(".button--submit").click
end

def click_back
  find(".button--back").click
end

def expect_page_to_have_progress_bar
  expect(page).to have_css(".progress-bar")
end

def click_for(for_value)
  find("label[for=#{for_value}]").click
end
