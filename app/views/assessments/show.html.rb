class Views::Assessments::Show < Views::Base
  needs :assessment

  def content
    row do
      columns do
        h1 "Yay, you're done!"

        h3 "Nodes selected:"
        ul do
          assessment.nodes.each { |node| li node.title }
        end

        h3 "Primary Referrals:"
        ul do
          assessment.primary_referrals.each { |referral| li referral.title }
        end

        h3 "Secondary Referrals:"
        ul do
          assessment.secondary_referrals.each { |referral| li referral.title }
        end

        h3 "Special Referrals:"
        ul do
          assessment.special_referrals.each { |referral| li referral.title }
        end

      end
    end
  end
end
