class Views::Application::Copyright < Views::Base
  def content
    div class: :copyright do
      mail_to "legallink@baylegal.org", "legallink@baylegal.org"
      text " • "
      link_to "415.851.1PLL", "tel:415-851-1755"
      text " (415.851.1755) • © #{Date.today.year} Project Legal Link. All Rights Reserved."
    end
  end
end
