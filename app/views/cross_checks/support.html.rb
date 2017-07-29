class Views::CrossChecks::Support < Views::Base
  include Views::CrossChecks::Helper
  needs :cross_check

  def content
    set_progress_bar! index: 15

    content_for :card do
      h4 "What level of support do you think you will need from PLL in order to support your client?"
      cross_check_form do |f|
        f.text_field :client_has_consulted_attorney, id: :square_value, type: :hidden
        div class: "square-collection" do
          render partial: "square", locals: {
            value: "low",
            label: "Low",
            description: "I think we found the right referral, but any additional resources from Project Legal Link would be helpful",
            icon: nil
          }
          render partial: "square", locals: {
            value: "medium",
            label: "Medium",
            description: "I am not sure we found the right referral, and would appreciate a cross-check from Project Legal Link",
            icon: nil
          }
          render partial: "square", locals: {
            value: "high",
            label: "High",
            description: "I am not sure we have identified the right legal issue, and me or the client need additional support from Project Legal Link",
            icon: nil
          }
        end
      end
    end
  end
end
