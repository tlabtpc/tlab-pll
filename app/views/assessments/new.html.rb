class Views::Assessments::New < Views::Base
  def content
    columns("small-centered", medium: 8, large: 7) do
      h4 'Before we start, please confirm the following:'

      assessment_check 'My client and I have enough time to work on this now.',
        'If not today, try to schedule a date and time to follow-up with your client.',
        'schedule'

      assessment_check 'I have asked my client if he/she has any paperwork related to this issue.',
        'Documents from a court, government agency, or attorney often include response times, appeal deadlines, and other important information.',
        'paperwork'

      assessment_check 'I understand that Project Legal Link does not provide legal representation for my client.',
        'This tool does not collect client-identifying information and does not create any attorney-client relationships.',
        'legal'
    end
  end

  def assessment_check(title, subtitle, id)
    input(class: "checkbox assessments__checkbox", id: "intro[#{id}]", type: "checkbox", name: "intro[#{title}]")
    label(for: "intro[#{id}]") do
      div(class: "label--check") { text "✓" }
      div(class: "label--text") do
        strong title
        p subtitle
      end
    end
  end
end
