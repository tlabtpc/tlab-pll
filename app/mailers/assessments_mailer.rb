class AssessmentsMailer < ApplicationMailer
  default from: 'no-reply@projectlegallink.org'

  def show(assessment, to:, cross_check: false)
    @assessment = assessment.decorate
    @cross_check = cross_check
    mail(to: to, subject: "Summary assessment ##{@assessment.to_param}")
  end
end
