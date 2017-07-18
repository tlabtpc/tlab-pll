class Views::PrimaryReferrals::EmailModal < Views::Base
  needs :primary_referral

  def content
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

      form_tag send_email_primary_referral_path, id: 'primary_referral_email_form', method: :post do
        hidden_field_tag 'id', primary_referral.id

        label_tag 'primary_referral_email_address', 'Email'
        email_field_tag \
          'primary_referral[email_address]',
          nil,
          id: 'primary_referral_email_address'

        check_box_tag 'primary_referral[client_confirmation]',
          'true',
          false,
          id: 'primary_referral_email_client_confirmation',
          class: 'primary-referral__checkbox-input'

        label_tag(
          'primary_referral_client_confirmation',
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
          label \
            'SUBMIT',
            class: 'button button--submit button--disabled',
            for: :primary_referral_email_submit
        end
      end
    end
  end
end