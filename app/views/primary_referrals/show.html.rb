class Views::PrimaryReferrals::Show < Views::Base
  needs :primary_referral

  def content
    content_for :card do
      email_modal

      div(class: 'primary-referral') do
        div(class: 'card-header primary-referral__card-header') do
          locale_select

          div do
            link_to '#', class: 'card-header__open-email-modal', 'data-open' => 'send-email-modal' do
              fa_icon "envelope"
              text 'Email'
            end
          end
        end

        hr

        h1 primary_referral.title, class: "primary-referral__title"

        p primary_referral.description

        div(data: { locale: "English" }, class: 'primary-referrals__markdown') do
          rawtext markdown(primary_referral.markdown_content)
        end

        div(data: { locale: "Spanish" }, class: 'primary-referrals__markdown hide') do
          rawtext markdown(primary_referral.markdown_content_es)
        end

      end
    end

    content_for :back do
      back_button assessment_referrals_path
    end
  end

  # I couldn't get select_tag to work.... :(
  def locale_select
    form_for :primary_referral do |f|
      f.label 'locale', for: :primary_referral_code, class: :hide
      f.select :code, ['English', 'Spanish'], {}, class: "primary-referrals__locale"
    end
  end

  def email_modal
    render "email_modal"
  end
end
