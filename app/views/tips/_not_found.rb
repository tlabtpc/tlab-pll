class Views::Tips::NotFound < Views::Base
  needs :node
  def content
    text "Warning: Unable to find template '#{node.tip.title}' in 'app/views/tips'"
    text "Have you run rake db:seed?"
  end
end
