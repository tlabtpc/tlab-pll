class Views::Tips::BenefitsSfOne < Views::Base
  def content
    render "tips/caseworker_header"
    p "Most legal help is available for problems with benefits, such as terminations, denials, or overpayments."
    p "If your client has experienced any of these problems, your client needs to act quickly and look into appeal options - there are always deadlines."
  end
  
end
