class Views::Dev::Index < Views::Base
  needs :routes

  def content
    row do
      columns do
        h1 "Select a test route:"
        ul do
          routes.each do |route|
            li { link_to route, "dev/#{route}" }
          end
        end
      end
    end
  end
end
