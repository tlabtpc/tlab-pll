class Views::Assessments::New < Views::Base
  needs :special_referrals

  def content
    set_progress_bar!(index: 1)

    content_for(:card) do
      div class: "assessments__form" do
        form_for :assessment, url: assessments_path do |f|
          card_title 'Before we start, please confirm the following:'

          assessment_check 'My client and I have enough time to work on this now.',
            'If not today, try to schedule a date and time to follow-up with your client.',
            'schedule'

          assessment_check 'I have asked my client if he/she has any paperwork related to this issue.',
            'Documents from a court, government agency, or attorney often include response times, appeal deadlines, and other important information.',
            'paperwork'

          assessment_check 'I understand that this tool is for me, the staff person, to find referrals and get support from Project Legal Link.',
            'This tool does not collect any client-identifying information and still requires that the client contact the legal referrals directly to get help.',
            'client'

          assessment_check 'I have read to my client the following:',
            'I am using a tool that non-profit lawyers from Project Legal Link created to help us find the right legal referrals. Using this tool does not make Project Legal Link your attorney.',
            'legal',
            last: true

          div(class: "assessments__special-referrals") do
            h4 <<-TEXT
              If your client fits into one of the following groups, check the box and we will
              provide additional referrals (if not, skip this step and hit 'next' below)
            TEXT
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

  def assessment_check(title, subtitle, id, last: false)
    input(class: "assessments__checkbox-input", id: "agree_#{id}", type: "checkbox")
    label(class: "assessments__checkbox-label assessments__checkbox-label-agreements #{('assessments__checkbox-label-agreements--last' if last)}", for: "agree_#{id}") do
      div(class: "assessments__checkbox-label-check") { fa_icon('check', 'fa-lg') }
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
        div(class: "assessments__checkbox-label-text")  { strong referral.intro }
      end
    end
  end
end
