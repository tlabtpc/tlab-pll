class Views::CrossChecks::Details < Views::Base
  include Views::CrossChecks::Helper
  needs :cross_check

  def content
    set_progress_bar! index: 9

    content_for :card do
      h4 "Please use the text box to give us additional details about your client's issue:"
      cross_check_form do |f|
        f.text_area :details,
          class: "cross-checks__textarea cross-checks__textarea--required",
          data: { description: "Please do not include any client-identifying information (ex: client names, dates of birth, SSNs)" },
          placeholder: "Please write a brief description without any client-identifying information (ex: no client names, dates of birth, SSNs, etc.)"
      end
    end

    content_for :tip do
      render 'tips/cross_check_details'
    end
  end
end
