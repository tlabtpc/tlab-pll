class Views::Tips::Assessment < Views::Base
  def content
    h4 class: 'tips__header' do
      i class: "fa fa-lightbulb-o"
      span "If your client is self-represented:"
    end
    p "Coach your client to be on time + meet deadlines, get help with paperwork at self-help center. Respectfully self-advocate"

    h4 class: 'tips__header' do
      i class: "fa fa-lightbulb-o"
      span "If your client already has an attorney:"
    end
    p "That attorney is the best resource for information on that case (including a public defender for a criminal case)."
  end
end
