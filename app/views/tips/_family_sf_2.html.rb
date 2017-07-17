class Views::Tips::Category < Views::Base
  def content
    render "tips/caseworker_header"
    p "Note that most of the free family law help is available for those experiencing domestic violence."
    p "Every courthouse has a Family Law Facilitator that will help clients with forms and process."
  end
end