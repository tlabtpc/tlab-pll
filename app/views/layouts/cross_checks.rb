class Views::Layouts::CrossChecks < Views::Layouts::Application
  needs :cross_check

  def content
    content_for(:back) do
      link_to previous_step_cross_check_path(cross_check, current_step: action_name), class: "button secondary" do
        i class: "fa fa-arrow-left"
        span "Back"
      end
    end

    content_for(:next) do
      label(class: "button button--green cross-checks__next-button", for: :cross_check_submit) do
        span "Next"
        i class: "fa fa-arrow-right"
      end
    end
    super
  end
end
