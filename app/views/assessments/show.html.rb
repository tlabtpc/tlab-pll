class Views::Assessments::Show < Views::Base
  needs :assessment

  def content
    content_for :card do
      email_modal

      div(class: "assessments__show") do
        div(class: 'card-header') do
          link_to '#', class: 'card-header__open-email-modal', 'data-open' => 'send-assessment-email-modal' do
            fa_icon "envelope"
            text 'Email'
          end
        end

        hr

        if assessment.caseworker_first_name
          h1 "Thank you, #{assessment.caseworker_first_name}!", class: "assessments__title"
        else
          h1 "Thank you!", class: "assessments__title"
        end
      end

      render "content"
      render "logos"
    end
  end

  private

  def email_modal
    render "email_modal"
  end
end
