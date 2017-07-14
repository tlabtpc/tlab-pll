class Views::AssessmentReferrals::Index < Views::Base
  needs :assessment

  def content
    content_for :card do
      div class: "assessment-referrals" do
        h4 "Here are referrals that may help your client with this issue:", class: "assessment-referrals__title"
        ul do
          assessment.primary_referrals.each do |referral|
            li { link_to(referral.title, primary_referral_path(referral)) }
          end
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
      link_to assessment_nodes_path, method: :delete, class: "button button--back secondary" do
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
end
