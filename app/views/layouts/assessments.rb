class Views::Layouts::Assessments < Views::Layouts::Application
  def content
    content_for(:footer)  { content_for_footer }
    super
  end

  def content_for_footer
    form_for :assessment, url: assessments_path do |f|
      button_tag class: "button assessments__next-button", type: :submit, disabled: true do
        span "Next"
        i class: "fa fa-arrow-right"
      end
    end
  end
end
