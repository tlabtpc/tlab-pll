class AssessmentsMailer < ApplicationMailer
  default from: 'no-reply@projectlegallink.org'

  def show(assessment, to:, cross_check: false)
    @assessment = assessment.decorate
    @cross_check = cross_check
    @bcc = ENV['ASSESSMENT_MAIL_BCC'] if @cross_check
    mail(to: to, bcc: @bcc, subject: "Summary assessment ##{@assessment.to_param}")
  end
end
