class Views::AssessmentsMailer::Show < Views::Shared::Mailer
  needs :assessment, :cross_check

  def content
    cross_check_summary
    legal_signature

    hr

    render "assessments/content"
  end

  private

  def cross_check_summary
    return unless cross_check

    p do
      text "Hi #{assessment.caseworker_first_name},"

      br

      text "Here is a summary of your issue. "\
        "Your reference # is #{assessment.to_param}."
    end
  end
end
