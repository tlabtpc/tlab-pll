require 'rails_helper'

describe Node do
  describe "#to_param" do
    it "should use the parameterized node title" do
      node = build(:node, title: "San Francisco")
      expect(node.to_param).to eq [node.id, node.title.parameterize].join("-")
    end
  end

  describe "#primary_referrals=" do
    let(:node) { create(:node, terminal: true) }
    let(:other_node) { create(:node, terminal: true) }
    let!(:first) { create :primary_referral, title: "first" }
    let!(:second) { create :primary_referral, title: "second" }
    let!(:third) { create :primary_referral, title: "third" }

    it "sets primary referrals on a terminal node, with order" do
      expect {
        node.primary_referrals = ["first", "second", "third"]
      }.to change { node.reload.referrals.count }.by(3)

      expect {
        other_node.primary_referrals = ["first", "second", "third"]
      }.to_not change { node.reload.referrals.count }
    end

    it "sets position on node_referrals" do
      node.primary_referrals = ["first", "second", "third"]
      expect(node.node_referrals.find_by(referral: first).position).to  eq 0
      expect(node.node_referrals.find_by(referral: second).position).to eq 1
      expect(node.node_referrals.find_by(referral: third).position).to  eq 2
    end

    it "deals with unknown referral titles" do
      expect {
        node.primary_referrals = ["first", "whomp"]
      }.to_not raise_error
    end
  end
end
