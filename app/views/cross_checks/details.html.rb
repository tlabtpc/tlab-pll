class Views::CrossChecks::Details < Views::Base
  include Views::CrossChecks::Helper
  needs :cross_check

  def content
    content_for :card do
      h4 "Please use the text box to give us additional details about your client's issue:"
      cross_check_form { |f| f.text_area :details, class: "cross-checks__textarea", placeholder: "Please write a brief description without any client-identifying information (ex: no client names, dates of birth, SSNs, etc.)" }
    end
  end
end
