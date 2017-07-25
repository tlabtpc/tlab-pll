class Views::PrimaryReferralsMailer::Show < Views::Shared::Mailer
  include ApplicationHelper
  needs :referral

  def content
    legal_signature

    h4 referral.title

    rawtext markdown(referral.markdown_content)
  end
end
