class Views::Tips::HousingSf1 < Views::Base
  def content
    render "tips/caseworker_header"
    p "If your client has received an unlawful detainer (eviction proceeding in court),
make sure to act immediately or your client could risk losing housing."
  end
end
