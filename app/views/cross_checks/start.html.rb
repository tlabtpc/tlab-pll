class Views::CrossChecks::Start < Views::Base
  include Views::CrossChecks::Helper
  needs :cross_check

  def content
    content_for :card do
      h4 "Would you like a PLL Cross-Check?"

      cross_check_form do |f|
        div class: "square-collection" do
          f.text_field :perform_check, id: :square_value, type: :hidden

          render partial: "square", locals: {
            value: 1,
            text: "Yes, I want PLL to review my client’s issue",
            description: "Great. To do this we'll need to gather a bit more information"
          }

          render partial: "square", locals: {
            value: 0,
            text: "No, just give me the summary",
            description: "Okay, we’ll take you straight to your assessment"
           }
        end
      end
    end

    content_for :tip do
      render 'tips/caseworker_header'

      p <<~TEXT
        If you request a cross-check, PLL will review your client’s
        situation and the referral you made and offer other
        suggestions or options.
      TEXT
    end
  end
end
