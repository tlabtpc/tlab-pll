class Views::Assessments::Content < Views::Base
  include Rails.application.routes.url_helpers

  needs :assessment
  needs :context

  def content
    div class: "assessments__summary" do
      h2 "Summary of Issue", class: "assessments__title"
      assessment_info "Location: ", assessment.county_name
      assessment_info "Issue: ", assessment.issue_description
      assessment.include_in_summary_nodes.each do |node|
        assessment_info "#{node.question}: ", node.title
      end
      assessment_info "Description: ", assessment.details
      assessment_info "Deadlines: ", assessment.deadlines
      assessment_info "Attorney: ", assessment.attorney_status
    end

    div class: "assessments__summary" do
      h2 "#{assessment.featured_referrals.count} Referrals", class: "assessments__title"
      assessment.featured_referrals.each { |referral| featured_referral(referral) }
    end

    div class: "assessments__summary" do
      h2 "Other Resources", class: "assessments__title"
      assessment.secondary_referrals.each { |referral| secondary_referral(referral) }
    end

    if assessment.action_items.present?
      div class: "assessments__summary" do
        h2 "Follow-up Support Actions", class: "assessments__title"
        assessment.action_items.each do |item|
          p class: "assessments__action-item" do
            fa_icon "check"
            text item
          end
        end
      end
    end

    div class: "assessments__summary" do
      h2 "Don't forget", class: "assessments__title"
      render "tips/assessment"
    end

    div class: "assessments__summary" do
      h2 "Project Legal Link Cross-Check", class: "assessments__title"
      assessment_info "Reference Number: ", assessment.display_reference_id
      assessment_info "Today's date: ", assessment.display_submitted_at
      assessment_info "Caseworker Name: ", assessment.caseworker_name
      assessment_info "Caseworker Phone: ", assessment.caseworker_phone
      assessment_info "Caseworker Email: ", assessment.caseworker_email
      assessment_info "Organization Name: ", assessment.caseworker_organization
    end if assessment.caseworker_name.present?
  end

  private

  def assessment_info(title, value)
    p class: "assessments__info" do
      strong title
      text value
    end if value.present?
  end

  def featured_referral(referral)
    i(referral.unique_identifier)
    h4 class: "tips__header" do
      i class: "fa fa-telegram"
      span referral.title
    end
    p referral.description
    p { link_to link_for(referral), link_for(referral), class: "assessments__link" }
  end

  def secondary_referral(referral)
    p class: "assessments__secondary-referral" do
      fa_icon "external-link", "fa-lg"
      link_to(referral.title, referral.link, class: "assessments__link", target: "_blank")
    end
  end

  def link_for(referral)
    if context == :email && referral.link.present?
      referral.link_with_protocol
    else
      primary_referral_url(referral)
    end
  end
end
