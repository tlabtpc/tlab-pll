class Promulgators::Node < Promulgators::Base
  attr_reader :parent

  def initialize(files, parent = nil)
    super(files)
    @parent = parent
  end

  def promulgate!
    records_to_promulgate.each_with_index do |record, index|
      self.class.new(files_tail, create_model(record.merge(priority: index))).promulgate!
    end if files.present?
  end

  private

  def resource
    :node
  end

  def find_by_hash(record)
    { parent_node: parent, title: record['title'] }
  end
end
