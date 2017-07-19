class AssessmentsMailer < ApplicationMailer
  default from: 'no-reply@projectlegallink.org'

  def show(assessment, to:)
    @assessment = assessment.decorate
    mail(to: to, subject: "Summary assessment ##{@assessment.to_param}")
  end
end
