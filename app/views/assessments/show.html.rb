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
            assessment.referrals.each { |referral| li referral.title }
          end
        end
      end
    end
  end
end
