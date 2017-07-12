  class Views::Tips::Category < Views::Base
  def content
    render "tips/caseworker_header"
    p "Does she have any paperwork? Where did she apply - can you look up that address? "
  end
end
