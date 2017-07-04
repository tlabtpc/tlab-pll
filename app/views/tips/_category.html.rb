class Views::Tips::Category < Views::Base
  def content
    render "tips/caseworker_header"
    p "View our Legal Frameworks to learn more about the following categories:"
    ul do
      li { link_to "Criminal", "#" }
      li { link_to "Family", "#" }
      li { link_to "Housing", "#" }
      li { link_to "Immigration", "#" }
    end
  end
end
