class Views::Assessments::New < Views::Base
  needs :special_referrals

  def content
    content_for(:card) do
      div class: "assessments__form" do
        form_for :assessment, url: assessments_path do |f|
          h4 'Before we start, please confirm the following:', class: 'assessments__title'

          assessment_check 'My client and I have enough time to work on this now.',
            'If not today, try to schedule a date and time to follow-up with your client.',
            'schedule'

          assessment_check 'I have asked my client if he/she has any paperwork related to this issue.',
            'Documents from a court, government agency, or attorney often include response times, appeal deadlines, and other important information.',
            'paperwork'

          assessment_check 'I understand that Project Legal Link does not provide legal representation for my client.',
            'This tool does not collect client-identifying information and does not create any attorney-client relationships.',
            'legal'

          div(class: "assessments__special-referrals") do
            h4 "Does your client fit into one of these groups? if so, they might be eligible for special assistance.", class: "assessments__title"
            ul(class: "assessments__special-referral-list") do
              special_referrals.each { |referral| special_referral_check f, referral }
            end
          end

          f.submit(class: "assessments__submit hide", id: :assessment_submit, disabled: true)
        end

        render "logos"
      end
    end

    content_for :next do
      label(class: "button button--submit button--disabled", for: :assessment_submit) do
        span "NEXT"
        i class: "fa fa-arrow-right"
      end
    end
  end

  def assessment_check(title, subtitle, id)
    input(class: "assessments__checkbox-input", id: "agree_#{id}", type: "checkbox")
    label(class: "assessments__checkbox-label assessments__checkbox-label-agreements", for: "agree_#{id}") do
      div(class: "assessments__checkbox-label-check") { i(class: "fa fa-lg fa-check") }
      div(class: "assessments__checkbox-label-text") do
        strong title
        p subtitle
      end
    end
  end

  def special_referral_check(form, referral)
    li do
      form.check_box(:referral_ids, {multiple: true, id: "referral_id_#{referral.id}"}, referral.id, nil)
      label(class: "assessments__checkbox-label", for: "referral_id_#{referral.id}") do
        div(class: "assessments__checkbox-label-check") { i(class: "fa fa-lg fa-check") }
        div(class: "assessments__checkbox-label-text")  { strong referral.title }
      end
    end
  end
end
