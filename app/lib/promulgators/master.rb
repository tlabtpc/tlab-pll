class Promulgators::Master < Promulgators::Base
  def promulgate!
    Promulgators::Referral.new(files: [:special, :primary, :secondary]).promulgate!
    Promulgators::Node.new(files: [:root, :counties_suburbs, :categories_suburbs]).promulgate!
    Promulgators::Node.new(files: [:root, :counties_sf, :categories_sf]).promulgate!

    Node.categories.each do |category|
      Promulgators::Node.new(files: files_for(category), parent: category).promulgate!
    end
  end

  private

  def files_for(category)
    Array(
      node_map.dig(category.parent_node.title, category.title) ||
      node_map.dig('default', category.title)
    )
  end

  def node_map
    @node_map ||= YAML.load_file("#{Rails.root}/config/data/nodes/map.yml")
  end
end
