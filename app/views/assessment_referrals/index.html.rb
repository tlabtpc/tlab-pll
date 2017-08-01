class Views::AssessmentReferrals::Index < Views::Base
  needs :assessment

  REFERRAL_INDEX = 7

  def content
    set_progress_bar! index: REFERRAL_INDEX

    content_for :card do
      div(class: 'assessment-referrals', 'data-update-path' => assessment_referral_path(0)) do
        h4 "Here are referrals that may help your client with this issue:",
          class: "assessment-referrals__title"

        ul do
          assessment.featured_assessment_referrals.each do |assessment_referral|
            featured_assessment_referrals(assessment_referral)
          end
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
      link_to start_cross_checks_path, class: "button button--submit" do
        text "NEXT"
        fa_icon 'arrow-right'
      end
    end
  end

  def featured_assessment_referrals(assessment_referral)
    referral = assessment_referral.referral
    i(referral.unique_identifier)

    referral_attrs = {
      class: 'assessment-referrals__primary-referral',
      'data-assessment-referral-id' => assessment_referral.id
    }

    if assessment_referral.has_usefulness?
      referral_attrs['data-useful'] = assessment_referral.useful.to_s
    end

    li(referral_attrs) do
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
            id: "assessment_referrals_#{referral.id}_usefulness-true",
            name: "assessment_referrals[#{referral.id}][useful]",
            class: 'assessment-referrals__usefulness-checkbox',
            value: 'true',
            type: 'radio'

          label 'YES',
            for: "assessment_referrals_#{referral.id}_usefulness-true",
            class: 'assessment-referrals__referral-usefulness-button'

          input \
            id: "assessment_referrals_#{referral.id}_usefulness-false",
            name: "assessment_referrals[#{referral.id}][useful]",
            class: 'assessment-referrals__usefulness-checkbox',
            value: 'false',
            type: 'radio'

          label 'NO',
            for: "assessment_referrals_#{referral.id}_usefulness-false",
            class: 'assessment-referrals__referral-usefulness-button'
        end
      end
    end
  end
end
