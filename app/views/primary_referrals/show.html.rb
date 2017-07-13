class Views::PrimaryReferrals::Show < Views::Base
  needs :primary_referral

  def content
    content_for :card do
      div(class: 'primary-referral') do
        div(class: 'primary-referral__markdown') do
          rawtext markdown(primary_referral.markdown_content)
        end
      end
    end

    content_for :back do
      link_to assessment_referrals_path do
        fa_icon "arrow-left"
        text "BACK"
      end
    end
  end
end
