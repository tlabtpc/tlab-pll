class Views::Tips::ImmigrationOther1 < Views::Base
  def content
    render "tips/caseworker_header"
    p "If your client has an immigration court date and does not have an attorney, she should try to find counsel immediately (especially if she is in removal proceedings)."
  end
end
