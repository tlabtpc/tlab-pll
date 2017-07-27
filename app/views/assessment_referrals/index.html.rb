class Views::AssessmentReferrals::Index < Views::Base
  needs :assessment

  REFERRAL_INDEX = 7

  def content
    set_progress_bar! index: REFERRAL_INDEX

    content_for :card do
      form_options = {
        method: 'PUT',
        class: 'assessment-referrals',
        id: 'assessment-referrals-form'
      }

      form_tag(assessment_referrals_path, form_options) do
        h4 "Here are referrals that may help your client with this issue:",
          class: "assessment-referrals__title"

        ul do
          assessment.featured_referrals.each { |referral| featured_referral(referral) }
        end

        if assessment.secondary_referrals.any?
          h4 "Other resources:", class: "assessment-referrals__title"
          ul do
            assessment.secondary_referrals.each do |referral|
              li class: "assessment-referrals__list-item" do
                fa_icon "external-link", "fa-lg"
                link_to(referral.title, referral.link, class: "assessment-referrals__link", target: "_blank")
              end
            end
          end
        end
      end
    end

    content_for :tip do
      render 'tips/referrals'
    end

    content_for :back do
      back_button assessment_nodes_path, method: :delete, class: "button button--back"
    end

    content_for :next do
      button(type: 'submit', id: 'assessment-referrals-submit', class: "button button--submit") do
        text "NEXT"
        fa_icon 'arrow-right'
      end
    end
  end

  def featured_referral(referral)
    i(referral.unique_identifier)

    li(class: "assessment-referrals__primary-referral") do
      div(class: 'assessment-referrals__primary-referral-inside') do
        h4 class: "assessment-referrals__title" do
          fa_icon "telegram"
          text referral.title
        end

        p(referral.description, class: "assessment-referrals__referral-description")

        link_to "GET REFERRAL INFO",
          primary_referral_path(referral),
          class: "button--submit assessment-referrals__button"

        div(class: 'assessment-referrals__referral-usefulness') do
          p  'Is this referral useful?',
            class: 'assessment-referrals__referral-usefulness-text'

          input \
            id: 'assessment_referrals_usefulness-true',
            name: "assessment-referrals[#{referral.id}][usefulness]",
            class: 'assessment-referrals__usefulness-checkbox',
            value: 'true',
            type: 'radio'

          label 'YES',
            for: 'assessment_referrals_usefulness-true',
            class: 'assessment-referrals__referral-usefulness-button'

          input \
            id: 'assessment_referrals_usefulness-false',
            name: "assessment-referrals[#{referral.id}][usefulness]",
            class: 'assessment-referrals__usefulness-checkbox',
            value: 'false',
            type: 'radio'
          label 'NO',
            for: 'assessment_referrals_usefulness-false',
            class: 'assessment-referrals__referral-usefulness-button'
        end
      end
    end

    # TODO: is this useful?
  end
end
