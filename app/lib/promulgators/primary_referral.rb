class Promulgators::PrimaryReferral < Promulgators::Base
  private

  def build_model_params(record)
    super.except(:markdown_content, :markdown_content_es)
  end

  def resource
    :referral
  end

  def find_by_hash(record)
    { code: record['code'] }
  end
end
