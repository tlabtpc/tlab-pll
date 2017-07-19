class Promulgators::PrimaryReferral < Promulgators::Base
  private

  def resource
    :referral
  end

  def find_by_hash(record)
    { code: record['code'] }
  end
end
