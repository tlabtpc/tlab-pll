NodePromulgator = Struct.new(:node_types, :parent) do

  # The promulgator reads a series of node data files,
  # which will be populated into a tree.
  # It optionally accepts an existing parent node to hang the
  # new tree nodes off of.
  def promulgate!
    records_to_promulgate.each do |record|
      NodePromulgator.new(node_types[1..-1], create_node(record)).promulgate!
    end if node_types.present?
  end

  private

  def records_to_promulgate
    @records ||= Array(data['records'])
  end

  def create_node(record)
    Node.find_or_create_by(parent_node: parent, title: record['title'])
        .tap { |node| node.update(defaults.merge(record)) }
  end

  def defaults
    @defaults ||= Hash(data['defaults'])
  end

  def data
    @data ||= YAML.load_file("#{Rails.root}/config/data/nodes/#{node_types.first}.yml")
  end
end
