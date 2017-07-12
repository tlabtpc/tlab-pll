class Views::CrossChecks::Support < Views::Base
  include Views::CrossChecks::Helper
  needs :cross_check

  def content
    content_for :card do
      h4 "What level of support do you think you will need from PLL in order to support your client?"
      cross_check_form do |f|
        f.text_field :client_has_consulted_attorney, id: :square_value, type: :hidden
        div class: "square-collection" do
          render partial: "square", locals: { value: "low", text: "Low", description: nil }
          render partial: "square", locals: { value: "medium", text: "Medium", description: nil }
          render partial: "square", locals: { value: "high", text: "High", description: nil }
        end
      end
    end
  end
end
