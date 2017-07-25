class Views::Tips::Category < Views::Base
  def content
    render "tips/caseworker_header"
    p "View our Legal Frameworks to learn more about the following categories:"
    ul do
      li { link_to "Criminal", "//projectlegallink.org/wp-content/uploads/2014/12/Criminal.pdf", class: "tips__link", target: "_blank" }
      li { link_to "Family", "//projectlegallink.org/wp-content/uploads/2014/12/Family.pdf", class: "tips__link", target: "_blank" }
      li { link_to "Housing", "//projectlegallink.org/wp-content/uploads/2014/12/Housing.pdf", class: "tips__link", target: "_blank" }
      li { link_to "Immigration", "//projectlegallink.org/wp-content/uploads/2014/12/Immigration.pdf", class: "tips__link", target: "_blank" }
    end
  end
end
