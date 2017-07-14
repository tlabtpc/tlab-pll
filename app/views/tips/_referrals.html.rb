class Views::Tips::Referrals < Views::Base
  needs :special_referrals

  def content
    render "tips/caseworker_header"
    p <<-TEXT.html_safe
      This is PLL's best guess. Assistance is not guaranteed and each
      organization has their own intake process and eligibility rules.
    TEXT
    p <<-TEXT.html_safe
      If you would like PLL to review your client's issue and provide
      additional resources, please request a <strong>PLL Cross Check</strong>
      on the next screen
    TEXT

    h4 class: 'tips__header' do
      fa_icon "telegram"
      span "More referrals"
    end
    p <<-TEXT
      Does your client fit into one of these groups? If so, they might
      be eligible for additional referrals.
    TEXT
    ul do
      special_referrals.each do |referral|
        li { link_to referral.title, primary_referral_path(referral), class: "tips__link" }
      end
    end
  end
end
