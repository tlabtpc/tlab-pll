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
    let!(:bbbb) { create :primary_referral, code: "bbbb" }
    let!(:aaaa) { create :primary_referral, code: "aaaa" }
    let!(:cccc) { create :primary_referral, code: "cccc" }

    it "sets primary referrals on a terminal node, with order" do
      other_node.primary_referrals = ["aaaa", "bbbb", "cccc"]

      expect {
        node.primary_referrals = ["aaaa", "cccc", "bbbb"]
      }.to change { node.reload.referrals.count }.from(0).to(3)

      expect {
        node.primary_referrals = ["bbbb", "aaaa", "cccc"]
      }.to_not change { node.reload.referrals.count }

      expect(node.node_referrals.order(:position).first.referral.code).to eq "bbbb"
      expect(node.node_referrals.order(:position).last.referral.code).to eq "cccc"
    end

    it "deals with unknown referral codes" do
      expect {
        node.primary_referrals = ["aaaa", "xxxx"]
      }.to_not raise_error
    end

    it "sets position on node_referrals" do
      node.primary_referrals = ["aaaa", "bbbb", "cccc"]
      expect(node.node_referrals.find_by(referral: aaaa).position).to  eq 0
      expect(node.node_referrals.find_by(referral: bbbb).position).to eq 1
      expect(node.node_referrals.find_by(referral: cccc).position).to  eq 2
    end
  end

  describe "#secondary_referrals=" do
    let(:node) { create(:node, terminal: true) }
    let(:other_node) { create(:node, terminal: true) }

    before do
      ["aaaa", "bbbb", "cccc"].each do |code|
        create(:primary_referral, code: code)
      end
      ["first", "second", "third"].each do |title|
        create(:secondary_referral, title: title)
      end
    end

    it "sets secondary referrals on a terminal node, with order" do
      node.primary_referrals = ["aaaa", "bbbb", "cccc"]
      other_node.primary_referrals = ["aaaa", "bbbb", "cccc"]

      expect {
        node.secondary_referrals = ["first", "second", "third"]
      }.to change { node.reload.referrals.count }.by(3)

      expect {
        other_node.secondary_referrals = ["first", "second", "third"]
      }.to_not change { node.reload.referrals.count }
    end

    it "deals with unknown secondary referral titles" do
      expect {
        node.secondary_referrals = ["first", "whomp"]
      }.to_not raise_error
    end

    it "can be included in the summary pages explicitly" do
      node.include_in_summary = true
      node.save!

      expect(node.include_in_summary).to be true
    end
  end
end
