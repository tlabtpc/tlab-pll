ReferralPromulgator = Struct.new(:referral_types) do
  def promulgate!
    return unless referral_types.present?
    records_to_promulgate.each { |record| create_referral(record) }
    ReferralPromulgator.new(referral_types[1..-1]).promulgate!
  end

  private

  def records_to_promulgate
    @records ||= Array(data['records'])
  end

  def create_referral(record)
    Referral.find_or_create_by(title: record['title'])
            .tap { |referral| referral.update(defaults.merge(record)) }
  end

  def defaults
    @defaults ||= Hash(data['defaults'])
  end

  def data
    @data ||= YAML.load_file("#{Rails.root}/config/data/referrals/#{referral_types.first}.yml")
  end
end
