class CodeTheNode
  def self.add_codes!
    Dir.chdir(Rails.root.join('config', 'data', 'nodes')) do
      Dir.glob("*.yml").each do |yml|
        YAML.load_file(yml).tap do |json|
          Array(json['records']).each { |record| record['code'] ||= SecureRandom.hex(8) }
          File.open(yml, 'w') { |f| f.write YAML.dump(json) }
        end
      end
    end
  end
end
