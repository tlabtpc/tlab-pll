class Views::PrimaryReferrals::Show < Views::Base
  needs :primary_referral

  def content
    content_for :card do
      email_modal

      div(class: 'primary-referral') do
        div(class: 'card-header') do
          link_to '#', class: 'card-header__open-email-modal', 'data-open' => 'send-email-modal' do
            fa_icon "envelope"
            text 'Email'
          end
        end

        hr

        div(class: 'primary-referral__markdown') do
          rawtext markdown(primary_referral.markdown_content)
        end
      end
    end

    content_for :back do
      link_to assessment_referrals_path, class: "button button--back" do
        fa_icon "arrow-left"
        text "BACK"
      end
    end
  end

  def email_modal
    render "email_modal"
  end
end
