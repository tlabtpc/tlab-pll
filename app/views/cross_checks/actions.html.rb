class Views::CrossChecks::Actions < Views::Base
  include Views::CrossChecks::Helper
  needs :cross_check

  def content
    content_for :card do
      cross_check_form do |f|
        h4 "Here are some actions that might help your client. Which of these are you able to support your client with?"

        h5 "Prepare"

        h5 "Take concrete steps"

        h5 "Follow-up"
      end
    end
  end
end
