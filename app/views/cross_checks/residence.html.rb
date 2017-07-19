class Views::CrossChecks::Residence < Views::Base
  include Views::CrossChecks::Helper
  needs :cross_check

  def content
    set_progress_bar! index: 12

    content_for :card do
      h4 "Does your client also reside in San Francisco County?"
      cross_check_form do |f|
        f.text_field :client_is_in_sf, id: :square_value, type: :hidden
        div class: "square-collection" do
          render partial: "square", locals: { value: 1, text: "Yes", description: nil }
          render partial: "square", locals: { value: 0, text: "No", description: nil }
        end
      end
    end
  end
end
