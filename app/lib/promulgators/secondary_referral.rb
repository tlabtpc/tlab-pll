class Promulgators::SecondaryReferral < Promulgators::Base
  private
  
  def resource
    :referral
  end

  def find_by_hash(record)
    { title: record['title'] }
  end
end
