class Views::Application::Square < Views::Base
  needs :text
  needs :value
  needs :description

  def content
    li text, class: :square, data: { value: value, description: description }
  end
end
