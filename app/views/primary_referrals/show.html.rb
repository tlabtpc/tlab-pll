class Views::PrimaryReferrals::Show < Views::Base
  needs :primary_referral

  def content
    div(id: "myModal",
      class: "reveal-modal",
      "data-reveal"=>"",
      "aria-labelledby"=>"modalTitle",
      "aria-hidden"=>"true",
      "role"=>"dialog"
    ) do
      h2(id: "modalTitle") {text "Awesome"}
      p "sdfjkhjkhdf"
      a(class:"close-reveal-modal", "aria-label"=>"Close") do
        raw "&#215;"
      end
    end

    content_for :card do
      div(class: 'primary-referral') do
        link_to "#", {"data-reveal-id"=>"myModal"} do
          fa_icon "envelope"
        end
        div(class: 'primary-referral__markdown') do
          rawtext markdown(primary_referral.markdown_content)
        end
      end
    end

    content_for :back do
      link_to assessment_referrals_path do
        fa_icon "arrow-left"
        text "BACK"
      end
    end
  end
end
