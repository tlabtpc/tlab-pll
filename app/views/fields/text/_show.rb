class Views::Fields::Text::Show < Views::Base
  include ApplicationHelper
  needs :field

  def content
    span { text markdown(field.data) }
  end
end
