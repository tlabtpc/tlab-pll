class Views::CrossChecks::CountySelect < Views::Base
  include Views::CrossChecks::Helper
  needs :cross_check

  def content
    set_progress_bar! index: 12

    content_for :card do
      h4 "What county does your client live in? If homeless, where does your "\
        "client stay?"

      cross_check_form do |f|
        f.text_field :county_node_id, id: :square_value, type: :hidden

        div class: "square-collection" do
          Node.counties.each do |county_node|
            render partial: "square",
              locals: {
                value: county_node.id,
                text: county_node.title,
                description: nil
              }
          end
        end
      end
    end
  end
end
