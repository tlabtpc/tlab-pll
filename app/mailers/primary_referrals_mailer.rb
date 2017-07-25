class PrimaryReferralsMailer < ApplicationMailer
  default from: 'no-reply@projectlegallink.org'

  def show(referral, to:)
    @referral = referral
    mail(to: to, subject: "Project Legal Link Referral: #{@referral.title}")
  end
end
