class Views::Admin::Application::Navigation < Views::Base
  def content
    nav class: :navigation, role: :navigation do
      Administrate::Namespace.new(namespace).resources.each do |resource|
        link_to(
          display_resource_name(resource),
          [namespace, resource.path],
          class: "navigation__link navigation__link--#{nav_link_state(resource)}"
        )
      end
      link_to(
        "Log out",
        sessions_path,
        method: :delete,
        class: "navigation__link"
      )
    end
  end
end
