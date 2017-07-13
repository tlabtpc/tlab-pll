class Views::CrossChecks::Deadlines < Views::Base
  include Views::CrossChecks::Helper
  needs :cross_check

  def content
    content_for :card do
      h4 "If your client has any deadlines they need to meet, please describe them below"
      cross_check_form do |f|
        f.label :deadlines, class: "hide"
        f.text_area :deadlines, class: "cross-checks__textarea cross-checks__textarea--required"
      end
    end

    content_for :tip do
      div(class: :tips) do
        render 'tips/cross_check_deadlines'
      end
    end
  end
end
