class Views::AssessmentReferrals::Index < Views::Base
  needs :assessment

  REFERRAL_INDEX = 7

  def content
    set_progress_bar! index: REFERRAL_INDEX

    content_for :card do
      div class: "assessment-referrals" do
        h4 "Here are referrals that may help your client with this issue:", class: "assessment-referrals__title"
        ul do
          assessment.featured_referrals.each { |referral| featured_referral(referral) }
        end

        if assessment.secondary_referrals.any?
          h4 "Other resources:", class: "assessment-referrals__title"
          ul do
            assessment.secondary_referrals.each do |referral|
              li class: "assessment-referrals__list-item" do
                fa_icon "external-link", "fa-lg"
                link_to(referral.title, referral.link, class: "assessment-referrals__link")
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
      link_to assessment_nodes_path, method: :delete, class: "button button--back" do
        fa_icon "arrow-left"
        text "BACK"
      end
    end

    content_for :next do
      link_to start_cross_checks_path, class: "button button--submit" do
        text "NEXT"
        fa_icon 'arrow-right'
      end
    end
  end

  def featured_referral(referral)
    p referral.unique_identifier
    li(class: "assessment-referrals__primary-referral") do
      h4 class: "assessment-referrals__title" do
        fa_icon "telegram"
        text referral.title
      end
      p referral.description
      link_to "GET REFERRAL INFO", primary_referral_path(referral), class: "button--submit assessment-referrals__button"
    end
    # TODO: is this useful?
  end
end
