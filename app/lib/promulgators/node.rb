class Promulgators::Node < Promulgators::Base
  attr_reader :parent

  def initialize(files: [], parent: nil)
    super(files: files)
    @parent = parent
  end

  def promulgate!
    return if !files.present? || parent&.terminal?
    records_to_promulgate.each_with_index do |record, index|
      self.class.new(
        files: files[1..-1],
        parent: create_model(record, index)
      ).promulgate!
    end
  end

  private

  def build_model_params(attrs, record, index)
    super.merge(position: index)
  end

  def resource
    :node
  end

  def find_by_hash(record)
    { parent_node: parent, code: record['code'] }
  end
end
