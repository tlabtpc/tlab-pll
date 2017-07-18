class Views::CrossChecks::Info < Views::Base
  include Views::CrossChecks::Helper
  needs :cross_check

  def content
    content_for :card do
      h4 "Please provide the following:"
      cross_check_form do |f|
        f.label :name, for: :cross_check_first_name
        f.text_field :first_name

        f.label :name, for: :cross_check_last_name
        f.text_field :last_name

        f.label :phone, for: :cross_check_caseworker_phone
        f.text_field :caseworker_phone

        f.label :email, for: :cross_check_caseworker_email
        f.text_field :caseworker_email

        f.label 'Your org', for: :cross_check_caseworker_organization
        f.select :caseworker_organization,
          ['Community Housing Partnership', 'Compass'],
          include_blank: true

        long_term_radios(f)
        client_is_homeless(f)
      end
    end
  end

  private

  def long_term_radios(f)
    f.label 'Do you plan to work with this client consistently for 2 months or more?'

    f.radio_button :client_is_long_term, 'yes', id: :client_is_long_term_yes
    f.label 'Yes', for: :client_is_long_term_yes

    f.radio_button :client_is_long_term, 'no', id: :client_is_long_term_no
    f.label 'No', for: :client_is_long_term_no

    f.radio_button :client_is_long_term,
      'i_dont_know',
      id: :client_is_long_term_unknown
    f.label "I don't know", for: :client_is_long_term_unknown
  end

  def client_is_homeless(f)
    f.label 'Are you working with this client on getting housed?'

    f.radio_button :client_is_homeless, true, id: :client_is_homeless_yes
    f.label 'Yes', for: :client_is_homeless_yes

    f.radio_button :client_is_homeless, false, id: :client_is_homeless_no
    f.label 'No', for: :client_is_homeless_no
  end
end
