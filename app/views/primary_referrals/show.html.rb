class Views::PrimaryReferrals::Show < Views::Base
  needs :primary_referral

  def content
    div(class: 'primary-referral') do
      hr

      div(class: 'primary-referral__markdown') do
        rawtext markdown(primary_referral.markdown_content)
      end

      hr

      render partial: "copyright"
    end

    content_for :back do
      link_to '#' do
        fa_icon 'long-arrow-left'
        text 'back'
      end
    end
  end
end
