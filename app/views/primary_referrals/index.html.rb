class Views::PrimaryReferrals::Index < Views::Base
  needs :assessment

  def content
    content_for :card do
      div class: "primary-referrals" do
        ul do
          assessment.primary_referrals.each do |referral|
            li { link_to(referral.title, primary_referral_path(referral)) }
          end
        end
      end
    end

    content_for :back do
      link_to assessment_nodes_path, method: :delete, class: "button button--back secondary" do
        fa_icon "long-arrow-left"
        text "BACK"
      end
    end

    content_for :next do
      link_to start_cross_checks_path, class: "button button--submit" do
        text "NEXT"
        fa_icon 'long-arrow-right'
      end
    end
  end
end
