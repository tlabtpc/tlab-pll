class Views::Tips::CrossCheckRepresentation < Views::Base
  def content
    render "tips/caseworker_header"

    p <<~TEXT.html_safe
      If your client has an attorney for any case, that attorney is the best 
      resource for information on that case (including a public defender for 
      a criminal case).
    TEXT
  end
end
