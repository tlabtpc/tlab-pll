class Views::PrimaryReferrals::Show < Views::Base
  needs :primary_referral

  def content
    div(class: "row card") do
      columns do
        text markdown(primary_referral.markdown_content)
      end
    end
    render partial: "copyright"
  end
end
