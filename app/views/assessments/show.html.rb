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

<<<<<<< HEAD
          h3 "Referrals:"
          ul do
            assessment.referrals.each { |referral| li referral.title }
          end
=======
        h3 "Referrals:"
        ul do
          assessment.referrals.primary.each do |referral|
            li link_to referral.id, primary_referral_path(referral)
          end
        end
>>>>>>> add benefits yml files

          h3 "Cross Check:"
          text "(cross check info goes here)"
        end
      end
    end
  end
end
