class PrimaryReferral < Referral
  def has_markdown?
    !!markdown_content
  end

  def has_markdown_es?
    !!markdown_content_es
  end
end
