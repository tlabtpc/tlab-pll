class Views::Tips::CrossCheckDetails < Views::Base
  def content
    render 'tips/caseworker_header'

    p <<~TEXT.html_safe
      We want to make sure we have the relevant pieces&mdash;please add
      anything you think we should know or that you are unsure of.
    TEXT
  end
end
