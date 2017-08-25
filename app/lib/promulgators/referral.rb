class Promulgators::Referral < Promulgators::Base
  private

  def build_model_params(attrs, record, index)
    super.merge(attrs.except('id', 'created_at').select { |k,v| v.present? })
  end

  def resource
    :referral
  end

  def find_by_hash(record)
    { code: record['code'] }
  end
end
