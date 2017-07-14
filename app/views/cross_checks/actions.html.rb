class Views::CrossChecks::Actions < Views::Base
  include Views::CrossChecks::Helper
  needs :cross_check

  def content
    content_for :card do
      cross_check_form do |f|
        h4 "Here are some actions that might help your client. Which of these are you able to support your client with?"

        h5 "Prepare", class: "action-items__header"
        action_item f, "Make a plan for next steps + help client document the plan"
        action_item f, "Help client clarify his/her questions (and write them down!)"

        h5 "Take concrete steps", class: "action-items__header"
        action_item f, "Obtain, locate, copy paperwork"
        action_item f, "Make an appointment for client"
        action_item f, "Accompany your client to an appointment or encourage her to find someone else to go with her"

        h5 "Follow-up", class: "action-items__header"
        action_item f, "Follow-up with your client to make sure she takes next steps and gets help"
      end
    end
  end

  def action_item(f, item_name)
    f.check_box :action_items, { multiple: true, id: item_name.parameterize }, item_name, nil
    f.label "", class: "action-items__checkbox-label", for: item_name.parameterize do
      div(class: "action-items__checkbox-label-check") { fa_icon "check", "fa-lg" }
      div(item_name, class: "action-items__checkbox-label-text")
    end
  end
end
