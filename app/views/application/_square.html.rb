class Views::Application::Square < Views::Base
  needs :label
  needs :value
  needs :description
  needs :icon

  def content
    li class: :square, data: { value: value, description: description } do
      div(class: "square__icon") { image_tag "icons/#{icon}" } if icon
      text label
    end
  end
end
