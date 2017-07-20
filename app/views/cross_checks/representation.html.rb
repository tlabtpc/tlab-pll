class Views::CrossChecks::Representation < Views::Base
  include Views::CrossChecks::Helper
  needs :cross_check

  def content
    set_progress_bar! index: 13

    content_for :card do
      h4 "Does your client have an attorney representing him/her?"

      cross_check_form do |f|
        f.text_field :client_has_attorney_representation,
          id: :square_value,
          type: :hidden

        div class: "square-collection" do
          render partial: "square", locals: {
            value: "representation_yes",
            label: "Yes",
            description: nil,
            icon: nil
          }

          render partial: "square", locals: {
            value: "representation_no",
            label: "No, they have only spoken to an attorney",
            description: nil,
            icon: nil
          }

          render partial: "square", locals: {
            value: "representation_i_dont_know",
            label: "I don't know",
            description: nil,
            icon: nil
          }
        end
      end
    end
  end
end
