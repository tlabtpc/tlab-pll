require 'rails_helper'

describe Node do
  describe "#to_param" do
    it "should use the node title" do
      node = create(:node)
      node.to_param.should == [node.id,node.title].join("-")
    end
  end

  describe "#primary_referrals=" do
    let(:node) { create(:node, terminal: true) }

    before do
      ["first", "second", "third"].each do |title|
        create(:primary_referral, title: title)
      end
    end

    it "sets primary referrals on a terminal node, with order" do
      expect {
        node.primary_referrals = ["first", "second", "third"]
      }.to change { node.reload.referrals.count }.by(3)
    end

    it "deals with unknown referral titles" do
      expect {
        node.primary_referrals = ["first", "whomp"]
      }.to_not raise_error
    end
  end
end

