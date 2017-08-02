class Views::Application::Square < Views::Base
  needs :label
  needs :value
  needs :description
  needs :icon

  def content

    li class: :square, data: { value: value, description: description, title: label } do
      div(class: "square__icon") { image_tag "icons/#{icon}.png" } if icon
      div(class: "square__icon--selected hide") { image_tag "icons/#{icon}_green.png" } if icon
      text label
    end
  end
end
