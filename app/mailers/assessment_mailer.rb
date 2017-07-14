class AssessmentMailer < ApplicationMailer
  default from: 'no-reply@projectlegallink.org'

  def referral_details_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
