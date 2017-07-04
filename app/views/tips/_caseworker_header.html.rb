class Views::Tips::CaseworkerHeader < Views::Base
  def content
    h4 class: 'tips__header' do
      i class: "fa fa-lightbulb-o"
      span "Caseworker Tip"
    end
  end
end
