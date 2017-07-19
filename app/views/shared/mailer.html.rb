class Views::Shared::Mailer < Views::Base
  def legal_signature
    p do
      text "Please do not reply to this email. If you have any questions "\
        "or comments, please email "

      mail_to "legallink@baylegal.org"

      text " or call 415.851.1PLL (415.851.1755)."
    end

    p do
      text "Sincerely,"
      br
      text "Project Legal Link"
    end
  end
end
