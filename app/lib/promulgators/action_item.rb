class Promulgators::ActionItem < Promulgators::Base
  private

  def resource
    :action_item
  end

  def find_by_hash(record)
    { name: record['name'] }
  end
end
