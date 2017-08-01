class Views::CrossChecks::Info < Views::Base
  include Views::CrossChecks::Helper
  needs :cross_check

  def content
    set_progress_bar! index: 10

    content_for :card do
      card_title "Please provide the following:"
      cross_check_form do |f|
        f.label 'Your first name *', for: :cross_check_first_name
        f.text_field :first_name, required: true, class: "cross-checks__input--required"

        f.label 'Your last name *', for: :cross_check_last_name
        f.text_field :last_name, required: true, class: "cross-checks__input--required"

        f.label "Phone *", for: :cross_check_caseworker_phone
        f.text_field :caseworker_phone, type: :tel, required: true, class: "cross-checks__input--required"

        f.label "Email *", for: :cross_check_caseworker_email
        f.text_field :caseworker_email, type: :email, required: true, class: "cross-checks__input--required"

        f.label 'Your org *', for: :cross_check_caseworker_organization
        f.select :caseworker_organization,
          ['Community Housing Partnership', 'Compass Family Services'],
          { include_blank: true },
          class: "cross-checks__input--required"

        long_term_radios(f)
        client_is_homeless(f)
      end
    end

    content_for :tip do
      render 'tips/cross_check_info'
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
