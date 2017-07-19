class Views::Assessments::Content < Views::Base
  include Rails.application.routes.url_helpers

  needs :assessment

  def content
    if assessment.details
      p "Project Legal Link will provide a cross-check and will follow-up with you.", class: "assessments__reference"
    end
    # TODO: this issue has been sent to person@socialservice.org?

    p class: "assessments__reference" do
      text "Reference "

      link_to assessment.reference_id,
        assessment_url(assessment),
        class: "assessments__link"
    end

    div class: "assessments__summary" do
      h2 "Summary of Issue", class: "assessments__title"
      assessment_info "Location: ", assessment.county_name
      assessment_info "Issue: ", assessment.category_name
      assessment_info "Description: ", assessment.details
      assessment_info "Deadlines: ", assessment.deadlines
      assessment_info "Attorney: ", assessment.attorney_status
    end

    div class: "assessments__summary" do
      h2 "Referrals", class: "assessments__title"
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
  end

  private

  def assessment_info(title, value)
    p class: "assessments__info" do
      strong title
      text value
    end if value.present?
  end

  def featured_referral(referral)
    h4 class: "tips__header" do
      i class: "fa fa-telegram"
      span referral.title
    end
    p referral.description
    p { link_to primary_referral_url(referral), primary_referral_url(referral), class: "assessments__link" }
  end

  def secondary_referral(referral)
    p class: "assessments__secondary-referral" do
      fa_icon "external-link", "fa-lg"
      link_to(referral.title, referral.link, class: "assessments__link")
    end
  end
end
