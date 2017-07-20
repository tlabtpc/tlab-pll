class Promulgators::Node < Promulgators::Base
  attr_reader :parent

  def initialize(files: [], path: [], parent: nil)
    super(files: files)
    @parent = parent || parent_from_path(path)
    raise "Could not navigate path" if @parent.blank? && path.present?
  end

  def promulgate!
    records_to_promulgate.each_with_index do |record, index|
      self.class.new(files: files[1..-1], parent: create_model(record, index)).promulgate!
    end if files.present?
  end

  private

  def parent_from_path(path, current = nil)
    return current unless path.any?
    parent_from_path path[1..-1], (current&.children || Node).find_by(title: path[0])
  end

  def resource
    :node
  end

  def order_column
    :position
  end

  def find_by_hash(record)
    { parent_node: parent, title: record['title'] }
  end
end
