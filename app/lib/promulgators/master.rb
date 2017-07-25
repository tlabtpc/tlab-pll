class Promulgators::Master < Promulgators::Base
  OTHER_BENEFITS_CODE = "c4d889fca8dda5f8".freeze

  def promulgate!
    Promulgators::SecondaryReferral.new(files: [:secondary]).promulgate!
    Promulgators::PrimaryReferral.new(files: [:special, :primary]).promulgate!
    Promulgators::Node.new(files: [:root, :counties, :categories]).promulgate!

    Node.categories.each do |category|
      Promulgators::Node.new(files: files_for(category), parent: category).promulgate!
    end

    Promulgators::Node.new(
      files: [:other_benefits_sf_1],
      parent: Node.find_by(code: OTHER_BENEFITS_CODE)
    )
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
