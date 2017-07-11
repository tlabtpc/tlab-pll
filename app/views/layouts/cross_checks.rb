class Views::Layouts::CrossChecks < Views::Layouts::Application
  needs :cross_check

  def content
    content_for(:card) do
      form_for :cross_check, url: next_step_cross_check_path(cross_check) do |f|
        f.text_field :current_step, value: action_name, type: :hidden
        yield
        f.submit(class: "cross-checks__submit", id: :cross_check_submit, disabled: true)
      end
    end

    content_for(:footer) do
      # back button
      link_to previous_step_cross_check_path(action_name), class: "button secondary" do
        i class: "fa fa-arrow-left"
        span "Back"
      end

      # next button
      div(class: "cross-checks__footer") do
        div
        label(class: "button button--green disabled", for: :cross_check_submit) do
          span "Next"
          i class: "fa fa-arrow-right"
        end
        div
      end
    end
    super
  end
end
