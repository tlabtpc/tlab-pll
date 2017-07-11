class Views::CrossChecks::Info < Views::Base
  include Views::CrossChecks::Helper
  needs :cross_check

  def content
    content_for :card do
      h4 "Please provide the following:"
      cross_check_form do |f|
        f.label :name
        f.text_field :caseworker_name

        f.label :phone
        f.text_field :caseworker_phone

        f.label :email
        f.text_field :caseworker_email
        # f.select for org

        # etc...
      end
    end
  end
end
