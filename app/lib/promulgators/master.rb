class Promulgators::Master < Promulgators::Base
  def promulgate!
    Promulgators::Referral.new(files: [:special, :primary, :secondary]).promulgate!
    Promulgators::Node.new(files: [:root, :counties, :categories]).promulgate!

    Node.counties.pluck(:title).each do |county|
      map_for(county).each { |category, files| promulgate_node_tree(county, category, files) }
    end

    Promulgators::NodeReferral.new(files: [:all]).promulgate!
  end

  private

  def map_for(county)
    node_map[county] || node_map['default']
  end

  def promulgate_node_tree(county, category, files)
    Promulgators::Node.new(path: [Node.root.title, county, category], files: files).promulgate!
  end

  def node_map
    @node_map ||= YAML.load_file("#{Rails.root}/config/data/nodes/map.yml")
  end
end
