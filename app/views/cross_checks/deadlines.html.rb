class Views::CrossChecks::Deadlines < Views::Base
  include Views::CrossChecks::Helper
  needs :cross_check

  def content
    set_progress_bar! index: 11

    content_for :card do
      card_title "If your client has any deadlines they need to meet, please describe them below"
      cross_check_form do |f|
        f.label :deadlines, class: "hide"
        f.text_area :deadlines, class: "cross-checks__textarea"
      end
    end

    content_for :tip do
      render 'tips/cross_check_deadlines'
    end
  end
end
