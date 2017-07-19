require 'rails_helper'

describe Promulgators::Referral do
  it 'populates referrals' do
    expect { Promulgators::Referral.new(files: [:test]).promulgate! }.to change { Referral.count }.by(4)
  end

  it 'populates default values' do
    Promulgators::Referral.new(files: [:test]).promulgate!
    expect(Referral.pluck(:markdown_content).uniq).to eq ["content"]
  end

  it 'does not overwrite existing referrals' do
    Promulgators::Referral.new(files: [:test]).promulgate!
    expect { Promulgators::Referral.new(files: [:test]).promulgate! }.to_not change { SpecialReferral.count }
  end
end
