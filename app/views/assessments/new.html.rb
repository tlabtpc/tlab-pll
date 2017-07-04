class Views::Assessments::New < Views::Base
  def content
    row do
      columns do
        h1 "Before we start, please confirm:"

        ul do
          assessment_check "My client and I have enough time to work on this now.",
                           "If not today, try to schedule a date and time to follow-up with your client"
          assessment_check "I have asked my client if they have any paperwork related to this issue.",
                           "Documents from a court, government agency, or attourney often include response times, appeal deadlines, and other important information."
          assessment_check "I understand that Project Legal Link does not provide legal representation for my client",
                           "This tool does not collect client-identifying information and does not create any attorney-client relationships"
        end

        div class: 'assessments__footer' do
          link_to assessments_path, method: :post, class: 'button button--next' do
            text "Next"
            i class: "fa fa-arrow-right"
          end
        end
      end
    end
  end

  def assessment_check(title, subtitle)
    li do
      div do
        h3 title, class: "assessments__check-title"
        h4 subtitle, class: "assessment__check-subtitle"
      end
    end
  end
end
