class Views::Tips::CrossCheckInfo < Views::Base
  def content
    render 'tips/caseworker_header'

    p <<~TEXT.html_safe
      We need this information to contact you and provide the best services.
    TEXT
  end
end
