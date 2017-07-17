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

    before do
      ["first", "second", "third"].each do |title|
        create(:primary_referral, title: title)
      end
    end

    it "sets primary referrals on a terminal node, with order" do
      expect {
        node.primary_referrals = ["first", "second", "third"]
      }.to change { node.reload.referrals.count }.by(3)

      expect {
        other_node.primary_referrals = ["first", "second", "third"]
      }.to_not change { node.reload.referrals.count }
    end

    it "deals with unknown referral titles" do
      expect {
        node.primary_referrals = ["first", "whomp"]
      }.to_not raise_error
    end
  end
end
