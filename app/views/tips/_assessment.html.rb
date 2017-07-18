class Views::Tips::Assessment < Views::Base
  def content
    h4 class: 'tips__header' do
      i class: "fa fa-lightbulb-o"
      span "If your client is self-represented..."
    end
    # TODO Look at content doc for this
    p "then coach your client to be on time + meet deadlines, get help with paperwork at self-help center. Respectfully self-advocate"

    h4 class: 'tips__header' do
      i class: "fa fa-lightbulb-o"
      span "If your client has an attorney for any case..."
    end
    p "Then that attorney is the best resource for information on that case (including a public defender for a criminal case)."
  end
end
