require 'rails_helper'
require 'rake'

describe 'rake db:seed' do
  subject { load "#{Rails.root}/db/seeds.rb" }

  it "should create nodes when there are none" do
    subject

    expect(Node.where(root: true).count).to eq 1
    expect(Node.counties.count).to eq 7
    expect(Node.categories.count).to eq(Node.counties.count * 8)
  end

  it "should not create nodes when they already exist" do
    subject

    root = Node.root
    category = Node.categories.first

    subject

    expect(root.reload.id).to eq Node.root.id
    expect(category.reload.id).to eq Node.categories.first.id
  end
end
