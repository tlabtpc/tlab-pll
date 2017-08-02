class PrimaryReferralsMailer < ApplicationMailer
  default from: 'no-reply@projectlegallink.org'

  def show(referral, render_spanish, to:)
    @referral = referral
    @render_spanish = render_spanish
    mail(to: to, subject: "Project Legal Link Referral: #{@referral.title}")
  end
end
