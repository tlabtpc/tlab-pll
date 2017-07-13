class Views::Tips::CrossCheckDeadlines < Views::Base
  def content
    render "tips/caseworker_header"

    p <<~TEXT.html_safe
      If your client has a court date, make a plan with your client to act
      quickly, get help and/or show up&mdash;it usually gets worse if your
      client doesn’t.
    TEXT

    render "tips/caseworker_header"

    p 'Ask to see paperwork.'

    p <<~TEXT
      Documents from a court, government agency, or attorney often
      include response times, appeal deadlines, and other relevant
      information.
    TEXT
  end
end
