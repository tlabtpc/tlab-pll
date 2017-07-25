class Views::Tips::FamilySfOne < Views::Base
  def content
    render "tips/caseworker_header"

    p <<~TEXT
      Domestic violence in a family law situation impacts the urgency of the
      issue and the kind of services available.
    TEXT

    p <<~TEXT
      Domestic violence is generally defined as: violence, threaths of
      violence, harassing, stalking, etc. from a close family member or
      boyfriend, girlfriend, partner, ex-partner, etc.
    TEXT

    p do
      text "Learn more "
      link_to "HERE",
        "http://www.courts.ca.gov/selfhelp-domesticviolence.htm",
        target: "_blank",
        class: "tips__link"
    end
  end
end
