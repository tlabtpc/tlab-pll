require 'rails_helper'
require 'rake'

describe 'rake db:seed' do
  def load_seeds
    suppress_output {
      load "#{Rails.root}/db/seeds.rb"
    }
  end

  it "should create nodes when there are none" do
    load_seeds

    expect(Node.where(root: true).count).to eq 1
    expect(Node.counties.count).to eq 7
    expect(Node.categories.count).to eq(Node.counties.count * 8)
  end

  it 'should populate the root node' do
    load_seeds

    root = Node.find_by(root: true)
    expect(root.title).to eq "County"
    expect(root.tip).to eq "county"
  end

  it "should not create nodes when they already exist" do
    load_seeds

    root = Node.root
    category = Node.categories.first

    node_count = Node.count
    referral_count = Referral.count
    node_referral_count = NodeReferral.count
    assessment_node_count = AssessmentNode.count
    assessment_referral_count = AssessmentReferral.count

    # load seeds again
    load_seeds

    # ensure no stray records have been added
    expect(Node.count).to eq node_count
    expect(Referral.count).to eq referral_count
    expect(NodeReferral.count).to eq node_referral_count
    expect(AssessmentNode.count).to eq assessment_node_count
    expect(AssessmentReferral.count).to eq assessment_referral_count

    expect(root.reload.id).to eq Node.root.id
    expect(category.reload.id).to eq Node.categories.first.id
  end

  it 'should associate primary referrals with all related nodes' do
    load_seeds

    expect(Node.root.referrals.count).to eq 0

    # sf-based immigration terminal node
    asylum_node = Node.find_by(title: "Asylum")
    expect(asylum_node.referrals.count).to eq 4

    icwc = Referral.find_by title: "Immigration Center for Women and Children, U-VISA and VAWA services (ICWC)"
    expect(icwc.nodes).to match_array [asylum_node]

    # suburb-based immigration terminal node
    crim_nodes = Node.where(title: "Criminal process + warrants")
    crim_nodes.each do |node|
      expect(node.referrals.count).to eq 2
    end

    def_offices = Referral.find_by title: "List of CA Public Defender Offices"
    expect(def_offices.nodes).to match_array crim_nodes
  end

end
