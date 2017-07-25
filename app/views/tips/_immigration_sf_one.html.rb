class Views::Tips::ImmigrationSfOne < Views::Base
  def content
    render "tips/caseworker_header"
    p do
      text "If the client is not sure what type of relief she might be eligible for, she can use the screening tool at "
      link_to "www.immi.org", "www.immi.org"
      text " to find out."
    end
    render "tips/caseworker_header"
    p "If your client has an immigration court date and does not have an attorney, she should try to find counsel immediately (especially if she is in removal proceedings)."
  end
end
