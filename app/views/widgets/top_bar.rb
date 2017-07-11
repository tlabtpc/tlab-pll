class Views::Widgets::TopBar < Views::Base
  # http://foundation.zurb.com/sites/docs/top-bar.html

  needs :title

  def content
    div class: "top-bar sticky" do
      div class: "top-bar-left" do
        image_tag "logo.png", alt: title
        p "Help your client take action with support from Project Legal Link"
      end
    end
  end
end
