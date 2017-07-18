class Promulgators::Node < Promulgators::Base
  attr_reader :parent

  def initialize(files:, path: [])
    super(files: files)
    @path = path
    raise "Could not navigate path" unless path.empty? || @parent = determine_parent(path)
  end

  def promulgate!
    records_to_promulgate.each_with_index do |child_node, index|
      created_node = create_model(child_node.merge(position: index))
      self.class.new(files: files_tail, path: create_model(child_node.merge(position: index))).promulgate!
    end if files.present?
  end

  private

  def determine_parent(current, path)
    return current unless path.any?
    determine_parent current.children.find_by(title: path[0]), path[1..-1]
  end

  def resource
    :node
  end

  def find_by_hash(record)
    { parent_node: parent, title: record['title'] }
  end
end
