class Views::PrimaryReferralsMailer::Show < Views::Shared::Mailer
  include ApplicationHelper
  needs :referral
  needs :render_spanish

  def content
    legal_signature

    h4 referral.title

    if render_spanish
      rawtext markdown(referral.markdown_content_es)
    else
      p referral.description

      rawtext markdown(referral.markdown_content)
    end
  end
end
