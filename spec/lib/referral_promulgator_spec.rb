require 'rails_helper'

describe 'Referral Promulgators' do
  it 'populates primary referrals' do
    expect {
      Promulgators::PrimaryReferral.new(files: [:test_primary]).promulgate!
    }.to change { Referral.count }.by(4)
  end

  it 'populates secondary referrals' do
    expect {
      Promulgators::SecondaryReferral.new(files: [:test_secondary]).promulgate!
    }.to change { Referral.count }.by(2)
  end

  it 'populates default values' do
    Promulgators::PrimaryReferral.new(files: [:test]).promulgate!
    expect(Referral.pluck(:markdown_content).uniq).to eq ["content"]
  end

  it 'does not overwrite existing referrals' do
    Promulgators::PrimaryReferral.new(files: [:test]).promulgate!
    expect { Promulgators::PrimaryReferral.new(files: [:test]).promulgate! }.to_not change { SpecialReferral.count }
  end
end
