class Views::CrossChecks::Start < Views::Base
  include Views::CrossChecks::Helper
  needs :cross_check

  def content
    set_progress_bar! index: 9

    content_for :card do
      card_title "Would you like a PLL Cross-Check?"

      cross_check_form do |f|
        div class: "square-collection" do
          f.text_field :perform_check, id: :square_value, type: :hidden

          render partial: "square", locals: {
            value: 1,
            label: "Yes, I want PLL to review my client’s issue",
            description: "Great. To do this we'll need to gather a bit more information",
            icon: nil
          }

          render partial: "square", locals: {
            value: 0,
            label: "No, just give me the summary",
            description: nil,
            icon: nil
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

    content_for :back do
      if cross_check.assessment.featured_referrals.any?
        back_button assessment_referrals_path
      else
        back_button assessment_nodes_path, method: :delete
      end
    end
  end
end
