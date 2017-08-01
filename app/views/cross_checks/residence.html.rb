class Views::CrossChecks::Residence < Views::Base
  include Views::CrossChecks::Helper
  needs :cross_check

  def content
    set_progress_bar! index: 12

    content_for :card do
      card_title "Does your client also live in #{cross_check.assessment.decorate.county_name} County?"
      cross_check_form do |f|
        f.text_field :client_is_in_issue_county, id: :square_value, type: :hidden
        div class: "square-collection" do
          render partial: "square", locals: {
            value: 1,
            label: "Yes",
            description: nil,
            icon: nil
          }

          render partial: "square", locals: {
            value: 0,
            label: "No",
            description: nil,
            icon: nil
          }
        end
      end
    end
  end
end
