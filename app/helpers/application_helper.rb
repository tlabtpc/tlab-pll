module ApplicationHelper
  def markdown(text)
    markdown_instance.render(text || '').html_safe
  end

  def controller_action_html_class
    "#{controller_name.underscore.dasherize}-#{action_name.underscore.dasherize}"
  end

  private

  def markdown_instance
    @markdown_instance ||= Redcarpet::Markdown
      .new(markdown_renderer, markdown_extension_options)
  end

  def markdown_renderer
    @renderer ||= Redcarpet::Render::HTML.new(markdown_options)
  end

  def markdown_options
    {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }
  end

  def markdown_extension_options
    {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }
  end
end
