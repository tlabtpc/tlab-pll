class Views::CrossChecks::New < Views::Base
  include Views::CrossChecks::Helper
  needs :cross_check

  def content
    content_for :card do
      h4 "Would you like a PLL Cross-Check?"
      cross_check_form
    end
  end
end
