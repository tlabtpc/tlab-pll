class Views::AssessmentsMailer::Show < Views::Shared::Mailer
  needs :assessment

  def content
    legal_signature

    render "assessments/content"
  end
end
