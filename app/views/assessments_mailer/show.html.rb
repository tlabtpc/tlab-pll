class Views::AssessmentsMailer::Show < Views::Shared::Mailer
  needs :assessment, :cross_check

  def content
    cross_check_summary
    legal_signature
    render "assessments/content", context: :email
  end

  private

  def cross_check_summary
    return unless cross_check

    p do
      div "Hi #{assessment.caseworker_first_name},"
      div "Here is a summary of your issue. Project Legal Link will perform a cross-check and follow-up with you within 2 working days"
      div "Your reference # is #{assessment.reference_id}"
    end
  end
end
