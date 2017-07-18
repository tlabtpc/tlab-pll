class Promulgators::Base
  attr_reader :files

  def initialize(files: [])
    @files = files
  end

  def promulgate!
    return unless files.present?
    records_to_promulgate.each { |record| create_model(record) }
    self.class.new(files: files[1..-1]).promulgate!
  end

  private

  def resource
    raise NotImplementedError.new
  end

  def find_by_hash(record)
    raise NotImplementedError.new
  end

  def resource_class
    resource.to_s.classify.constantize
  end

  def records_to_promulgate
    @records ||= Array(data['records'])
  end

  def create_model(record)
    resource_class.find_or_create_by(find_by_hash(record)).tap do |model|
      model.update(defaults.merge(record))
    end
  end

  def defaults
    @defaults ||= Hash(data['defaults'])
  end


  def data
    @data ||= YAML.load_file("#{Rails.root}/config/data/#{resource.to_s.pluralize}/#{files[0]}.yml")
  end
end
