class Views::CrossChecks::Start < Views::Base
  include Views::CrossChecks::Helper
  needs :cross_check

  def content
    content_for :card do
      h4 "Would you like a PLL Cross-Check?"
      cross_check_form do |form|
        div class: "square-collection" do
          form.text_field :begun, id: :square_value, type: :hidden
          render partial: "square", locals: { value: 1, text: "Yes", description: "Great. To do this we'll need to gather a bit more information" }
          render partial: "square", locals: { value: 0, text: "No", description: "Okay, we'll take you straight to your assessment" }
        end
      end
    end
  end
end
