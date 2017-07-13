class Views::PrimaryReferrals::Show < Views::Base
  needs :primary_referral

  def content
    content_for(:card) do
      rawtext markdown(primary_referral.markdown_content)
    end
  end
end
