class Views::CrossChecks::CountySelect < Views::Base
  include Views::CrossChecks::Helper
  needs :cross_check

  def content
    set_progress_bar! index: 12

    content_for :card do
      card_title "What county does your client live in? If homeless, where does your "\
        "client stay?"

      cross_check_form do |f|
        f.text_field :county_node_id, id: :square_value, type: :hidden

        div class: "square-collection" do
          Node.counties.each do |county_node|
            render partial: "square", locals: {
              value: county_node.id,
              label: county_node.title,
              description: nil,
              icon: nil
            }
          end
        end
      end
    end
  end
end
