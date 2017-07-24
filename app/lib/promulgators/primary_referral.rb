class Promulgators::PrimaryReferral < Promulgators::Base
  private

  def build_model_params(attrs, record, index)
    attrs.reverse_merge(super)
  end

  def resource
    :referral
  end

  def find_by_hash(record)
    { code: record['code'] }
  end
end
