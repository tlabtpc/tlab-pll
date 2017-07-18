class Views::PrimaryReferralsMailer::Show < Views::Base
  needs :referral

  def content
    text "THIS IS EMAIL CONTENT"
  end
end
