class Views::Fields::Text::Show < Views::Base
  include ApplicationHelper
  needs :field

  def content
    span { markdown(field.data) }
  end
end
