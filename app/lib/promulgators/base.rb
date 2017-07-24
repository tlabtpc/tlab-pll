class Promulgators::Base
  attr_reader :files

  def initialize(files: [])
    @files = files
  end

  def promulgate!
    return unless files.present?
    records_to_promulgate.each_with_index { |record, index| create_model(record, index) }
    self.class.new(files: files[1..-1]).promulgate!
  end

  private

  def resource
    raise NotImplementedError.new
  end

  def find_by_hash(record)
    raise NotImplementedError.new
  end

  def order_column
    :priority
  end

  def resource_class
    resource.to_s.classify.constantize
  end

  def records_to_promulgate
    @records ||= Array(data['records'])
  end

  def create_model(record, index)
    resource_class.find_or_create_by(find_by_hash(record)).tap do |model|
      attrs = model.attributes
      model.update!(build_model_params(attrs, record, index))
    end
  end

  def build_model_params(attrs, record, index)
    Hash(data['defaults']).merge(order_column => index).merge(record)
  end

  def data
    @data ||= YAML.load_file("#{Rails.root}/config/data/#{resource.to_s.pluralize}/#{files[0]}.yml")
  end
end
