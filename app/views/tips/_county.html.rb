class Views::Tips::County < Views::Base
  def content
    render "tips/caseworker_header"
    p "If this is unclear, take your best guess. You can clarify later."
    p "In general, if there is a court case pending, select the county that the case is in. If there isn't a case, the issue is likely where the client lives."
  end
end
