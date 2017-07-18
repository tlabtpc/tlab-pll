class PrimaryReferralsMailer < ApplicationMailer
  default from: 'no-reply@projectlegallink.org'

  def show(referral, to:)
    @referral = referral
    mail(to: to, subject: @referral.title)
  end
end
