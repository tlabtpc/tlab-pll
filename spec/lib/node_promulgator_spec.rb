require 'rails_helper'

describe NodePromulgator do
  it 'creates records from a single file' do
    expect { NodePromulgator.new([:test_a]).promulgate! }.to change { Node.count }.by(2)
    titles = Node.pluck(:title)
    expect(titles).to include "TestA1"
    expect(titles).to include "TestA2"
  end

  it 'populates defaults from the record file' do
    NodePromulgator.new([:test_a]).promulgate!
    expect(Node.pluck(:tip).uniq).to eq ['TestATip']
  end

  it 'propogates a tree of records recursively' do
    expect { NodePromulgator.new([:test_a, :test_b]).promulgate! }.to change { Node.count }.by(6)
    a1_titles = Node.find_by(title: "TestA1").children.pluck(:title)
    expect(a1_titles).to include "TestB1"
    expect(a1_titles).to include "TestB2"

    a2_titles = Node.find_by(title: "TestA1").children.pluck(:title)
    expect(a2_titles).to include "TestB1"
    expect(a2_titles).to include "TestB2"
  end

  it 'can populate records hanging off an existing node' do
    node = Node.create(title: "existing!")
    expect { NodePromulgator.new([:test_a], node).promulgate! }.to change { node.reload.children.count }.by(2)
  end
end