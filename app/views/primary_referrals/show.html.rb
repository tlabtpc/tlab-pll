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
      link_to '#' do
        fa_icon 'long-arrow-left'
        text 'back'
      end
    end
  end
end
