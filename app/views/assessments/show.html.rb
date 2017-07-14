class Views::Assessments::Show < Views::Base
  needs :assessment

  def content
    content_for :card do
      row do
        columns do
          h1 "Yay, you're done!"

          h3 "Nodes selected:"
          ul do
            assessment.nodes.each { |node| li node.title }
          end

          h3 "Referrals:"
          ul do
            assessment.primary_referrals.each do |referral|
              li { link_to referral.title, primary_referral_path(referral) }
            end

            assessment.secondary_referrals.each do |referral|
              li { text referral.title }
            end
          end

          h3 "Cross Check:"
          text "(cross check info goes here)"
        end
      end
    end
  end
end
