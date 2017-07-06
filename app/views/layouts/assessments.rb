class Views::Layouts::Assessments < Views::Layouts::Application
  def content
    content_for(:footer)  { content_for_footer }
    super
  end

  def content_for_footer
    link_to assessments_path, method: :post, class: 'button button--next', disabled: true do
      text 'Next'
      i class: 'fa fa-arrow-right'
    end
  end
end
