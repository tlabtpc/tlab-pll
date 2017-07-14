class Views::PrimaryReferrals::Show < Views::Base
  needs :primary_referral

  def content
    content_for :card do
      email_modal

      div(class: 'primary-referral') do
        div(class: 'primary-referral__top-bar') do
          link_to '#', class: 'primary-referral__open-email-modal', 'data-open' => 'send-email-modal' do
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
      link_to assessment_referrals_path do
        fa_icon "arrow-left"
        text "BACK"
      end
    end
  end

  def email_modal
    div(id: 'send-email-modal', class: 'reveal', 'data-reveal' => '') do
      h2('Email Resource', class: 'primary-referral__email-modal-header')

      close_attrs = {
        class: 'close-button primary-referral__email-modal-close',
        'data-close' => '',
        'aria-label' => 'Close modal',
        'type' => 'button'
      }

      button(close_attrs) do
        fa_icon 'close', 'fa-lg'
        span 'Close'
      end

      form_tag assessment_emails_path, id: 'primary_referral_email_form', method: :post do
        label_tag 'assessment_email_address', 'Email'
        email_field_tag \
          'assessment_email[address]',
          nil,
          id: 'primary_referral_email_address'

        check_box_tag 'assessment_email[client_confirmation]',
          'true',
          false,
          id: 'primary_referral_email_client_confirmation',
          class: 'primary-referral__checkbox-input'

        label_tag(
          'assessment_email_client_confirmation',
          class: 'primary-referral__checkbox-label primary-referral__checkbox-label--email',
          for: 'primary_referral_email_client_confirmation'
        ) do
          div(class: "primary-referral__checkbox-label-check "\
                     "primary-referral__checkbox-label-check--email") do
            fa_icon("check", "fa-lg")
          end

          div(class: "primary-referral__checkbox-label-text") do
            p <<~LABEL
              I understand that if I am sending to a client, I need the
              client to confirm that this is a safe email address and
              that I may send a legal referral to this address through
              this website.
            LABEL
          end
        end

        submit_tag '', class: 'hide', id: :primary_referral_email_submit
        div(class: 'primary-referral__email-submit-container') do
        label(class: 'button button--submit button--disabled', for: :primary_referral_email_submit) do
          span 'SUBMIT'
        end
        end
      end
    end
  end
end
