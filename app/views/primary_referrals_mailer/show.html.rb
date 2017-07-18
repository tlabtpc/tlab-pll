class Views::PrimaryReferralsMailer::Show < Views::Base
  needs :referral

  def content
    rawtext markdown(referral.markdown_content)
  end
end
