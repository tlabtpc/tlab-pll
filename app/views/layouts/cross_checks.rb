class Views::Layouts::CrossChecks < Views::Layouts::Application
  needs :cross_check

  def content
    content_for(:back) do
      break if content_for?(:back)
      back_button previous_step_cross_checks_path(current_step: action_name)
    end

    content_for(:next) do
      label(class: "button button--submit", for: :cross_check_submit) do
        span "Next"
        fa_icon 'arrow-right'
      end
    end

    super
  end
end
