class Views::Tips::SpecialReferrals < Views::Base
  def content
    h4 class: "tips__header" do
      i class: "fa fa-airplane"
      span "More Referrals"
    end

    p "Does your client fit into one of these groups? If so, they might be eligible for additional referrals"
  end
end
