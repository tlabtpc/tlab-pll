require 'rails_helper'

describe Promulgators::Node do
  it 'creates records from a single file' do
    expect { Promulgators::Node.new(files: [:test_a]).promulgate! }.to change { Node.count }.by(2)
    titles = Node.pluck(:title)
    expect(titles).to include "TestA1"
    expect(titles).to include "TestA2"
  end

  it 'populates defaults from the record file' do
    Promulgators::Node.new(files: [:test_a]).promulgate!
    expect(Node.pluck(:tip).uniq).to eq ['TestATip']
  end

  it 'populates priority based on yml file order' do
    Promulgators::Node.new(files: [:test_a]).promulgate!
    expect(Node.first.position).to eq 0
    expect(Node.last.position).to eq 1
  end

  it 'propogates a tree of records recursively' do
    Promulgators::Referral.new(files: [:test_primary]).promulgate!
    Promulgators::Referral.new(files: [:test_secondary]).promulgate!
    expect { Promulgators::Node.new(files: [:root, :test_a, :test_b]).promulgate! }.to change { Node.count }.by(5)

    root_titles = Node.find_by(title: "County").children.pluck(:title)
    expect(root_titles).to include "TestA1"
    expect(root_titles).to include "TestA2"

    a1_titles = Node.find_by(title: "TestA1").children.pluck(:title)
    expect(a1_titles).to include "TestB1"
    expect(a1_titles).to include "TestB2"

    # does not promulgate terminal nodes
    expect(Node.find_by(title: "TestA2").children).to be_empty
  end

  it "attaches referrals to all equivalent nodes" do
    Promulgators::Referral.new(files: [:test_primary]).promulgate!
    Promulgators::Referral.new(files: [:test_secondary]).promulgate!
    Promulgators::Node.new(files: [:root, :test_a, :test_b]).promulgate!
    b1nodes = Node.where(title: "TestB1")

    expect(b1nodes.last.reload.referrals.primary.count).to eq 1
    expect(b1nodes.first.reload.referrals.primary.count).to eq 1
    expect(b1nodes.last.reload.referrals.secondary.count).to eq 1
    expect(b1nodes.first.reload.referrals.secondary.count).to eq 1
  end

  it 'can populate records hanging off an existing node' do
    node = Node.create(title: "existing!")
    expect { Promulgators::Node.new(files: [:test_a], parent: node).promulgate! }.to change { node.reload.children.count }.by(2)
  end
end
