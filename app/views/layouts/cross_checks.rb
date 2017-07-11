class Views::Layouts::CrossChecks < Views::Layouts::Application
  needs :cross_check

  def content
    content_for(:card) do
      form_for :cross_check, url: next_step_cross_check_path(cross_check) do |f|
        f.text_field :current_step, value: action_name, type: :hidden
        super
        f.submit(class: "cross-checks__submit", id: :cross_check_submit, disabled: true)
      end
    end

    content_for(:footer) do
      div(class: "cross-checks__footer") do
        div
        label(class: "button button--green disabled", for: :cross_check_submit) do
          span "Next"
          i class: "fa fa-arrow-right"
        end
        div
      end
    end
  end
end
