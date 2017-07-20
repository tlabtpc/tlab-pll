class Views::Layouts::Admin < Views::Base

  def content
    content_for(:nav_right) do
      link_to "LOG OUT", sessions_path, method: :delete, class: "button button--back"
    end
  end
end
