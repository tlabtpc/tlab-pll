require 'rails_helper'

describe Node do
  describe "#to_param" do
    it "should use the node title" do
      node = create(:node)
      node.to_param.should == [node.id,node.title].join("-")
    end
  end
end

