class Views::Assessments::Show < Views::Base
  needs :assessment

  def content
    content_for :card do
      render "assessments/email_modal"

      div(class: "assessments__show") do
        div(class: 'card-header no-print') do
          card_header_actions(model: :assessment)
        end
        hr class: "no-print"

        if assessment.caseworker_first_name
          h1 "Thank you, #{assessment.caseworker_first_name}!", class: "assessments__title"
        else
          h1 "Thank you!", class: "assessments__title"
        end

        if assessment.caseworker_email
          p "Project Legal link will perform a cross-check and follow-up with you within 2 working days. A summary of this issue has been sent to #{assessment.caseworker_email}."
        end
      end

      p "Reference # #{assessment.reference_id}"
      render "content", context: :app
      render "logos"
    end

    content_for :next do
      link_to new_assessment_path, class: "button button--submit" do
        text "NEW ISSUE"
      end
    end
  end
end
