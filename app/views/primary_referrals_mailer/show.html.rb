class Views::PrimaryReferralsMailer::Show < Views::Base
  include ApplicationHelper
  needs :referral

  def content
    rawtext markdown(referral.markdown_content)
  end
end
