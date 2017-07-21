class Views::PrimaryReferrals::Show < Views::Base
  needs :primary_referral

  def content
    content_for :card do
      render "primary_referrals/email_modal"

      div(class: 'primary-referral') do
        div(class: 'card-header no-print primary-referral__card-header') do
          locale_select
          card_header_actions(model: :referral)
        end
        hr class: "no-print"

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
end
