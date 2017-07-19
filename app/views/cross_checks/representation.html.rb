class Views::CrossChecks::Representation < Views::Base
  include Views::CrossChecks::Helper
  needs :cross_check

  def content
    content_for :card do
      h4 "Does your client have an attorney representing him/her?"

      cross_check_form do |f|
        f.text_field :client_has_attorney_representation,
          id: :square_value,
          type: :hidden

        div class: "square-collection" do
          render partial: "square",
            locals: {
              value: "representation_yes",
              text: "Yes",
              description: nil
            }

          render partial: "square",
            locals: {
              value: "representation_no",
              text: "No, they have only spoken to an attorney",
              description: nil
            }

          render partial: "square",
            locals: {
              value: "representation_i_dont_know",
              text: "I don't know",
              description: nil
            }
        end
      end
    end
  end
end
