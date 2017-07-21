class Views::Widgets::TopBar < Views::Base
  needs :title

  def content
    div class: "top-bar no-print sticky" do
      div class: "top-bar__content" do
        div do
          image_tag "logo.png", alt: title
          p "Help your client take action with support from Project Legal Link"
        end
        div
      end
    end
  end
end
