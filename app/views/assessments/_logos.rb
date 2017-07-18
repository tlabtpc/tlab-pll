class Views::Assessments::Logos < Views::Base
  def content
    div class: "card__footer" do
      image_tag "project_legal_link.png", class: "card__image"
      image_tag "bay_area_legal_aid.png", class: "card__image"
      p "Project Legal Link is a program of Bay Area Legal Aid"
    end
  end
end
