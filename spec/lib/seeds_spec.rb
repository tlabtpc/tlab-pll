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

    sf_other_idontknow_county_count = 3
    categories_for_sf_other_idontknow = 7

    suburb_county_count = 5
    categories_suburb_count = 6

    expect(Node.categories.count).to eq(
      (sf_other_idontknow_county_count * categories_for_sf_other_idontknow)+
        (suburb_county_count * categories_suburb_count)
    )
  end

  it "should order the counties by positions in yaml files" do
    load_seeds

    root = Node.find_by(root: true)
    expect(root.children.first.title).to eq "Alameda"
    expect(root.children.last.title).to eq "Other / I don't know"
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

    ebsc = Referral.find_by(title: "East Bay Sanctuary Covenant")
    expect(ebsc.nodes).to include asylum_node

    # other counties common terminal node + referral
    county_nodes = Node.where(title: "Consumer: non-legal help")
    sparkpoint = Referral.find_by(title: "Sparkpoint")

    expect(sparkpoint.nodes.count).to eq 5

    sparkpoint.nodes.each do |node|
      expect(county_nodes).to include node
    end
  end

end
