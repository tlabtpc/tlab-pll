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

        h1 do
          strong primary_referral.title, class: "primary-referral__title"
        end

        div(data: { locale: "English" }, class: 'primary-referrals__markdown') do
          p primary_referral.description

          rawtext markdown(primary_referral.markdown_content)
        end

        div(data: { locale: "Spanish" }, class: 'primary-referrals__markdown hide') do
          rawtext markdown(primary_referral.markdown_content_es)
        end

      end
    end

    content_for :next do
      link_to assessment_referrals_path, class: "button button--submit" do
        text "CLOSE REFERRAL"
      end
    end

    content_for :flash do
      text <<-TEXT
        This screen contains information that may be valuable to your client.
        Please provide them with a print or email copy and ask your client to
        follow-up with the organization.
      TEXT
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
