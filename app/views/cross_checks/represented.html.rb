class Views::CrossChecks::Represented < Views::Base
  include Views::CrossChecks::Helper
  needs :cross_check

  def content
    content_for :card do
      h4 "Does your client have an attorney representing him/her?"
      cross_check_form do |f|
        f.text_field :client_is_represented, id: :square_value, type: :hidden
        div class: "square-collection" do
          render partial: "square", locals: {
            value: "yes",
            text: "Yes",
            description: nil,
            icon: nil
          }

          render partial: "square", locals: {
            value: "no",
            text: "No,
            they have only spoken to an attorney",
            description: nil,
            icon: nil
          }

          render partial: "square", locals: {
            value: "i_dont_know",
            text: "I don't know",
            description: nil,
            icon: nil
          }

        end
      end
    end
  end
end
