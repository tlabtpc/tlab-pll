class Views::CrossChecks::Consulted < Views::Base
  include Views::CrossChecks::Helper
  needs :cross_check

  def content
    set_progress_bar! index: 13

    content_for :card do
      h4 "Has your client consulted with an attorney on this issue?"
      cross_check_form do |f|
        f.text_field :client_has_consulted_attorney, id: :square_value, type: :hidden
        div class: "square-collection" do
          render partial: "square",
            locals: {
              value: "consulted_yes",
              text: "Yes",
              description: nil
            }

          render partial: "square",
            locals: {
              value: "consulted_no",
              text: "No",
              description: nil
            }

          render partial: "square",
            locals: {
              value: "consulted_i_dont_know",
              text: "I don't know",
              description: nil
            }
        end
      end
    end
  end
end
