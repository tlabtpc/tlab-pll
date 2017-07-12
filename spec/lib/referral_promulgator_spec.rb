require 'rails_helper'

describe Promulgators::Referral do
  it 'populates special referrals' do
    expect { Promulgators::Referral.new([:test]).promulgate! }.to change { SpecialReferral.count }.by(2)
  end

  it 'populates default values' do
    ReferralPromulgator.new([:test]).promulgate!
    expect(Referral.pluck(:markdown_content).uniq).to eq ["content"]
  end

  it 'does not overwrite existing referrals' do
    Promulgators::Referral.new([:test]).promulgate!
    expect { Promulgators::Referral.new([:test]).promulgate! }.to_not change { SpecialReferral.count }
  end
end
