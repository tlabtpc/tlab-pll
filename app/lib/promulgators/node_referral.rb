class Promulgators::NodeReferral < Promulgators::Base

  def promulgate!
    
  end

  private

  def resource
    :node_referral
  end

  def find_by_hash(record)
    { node_id: record['node_id'], referral_id: record['referral_id'] }
  end
end
