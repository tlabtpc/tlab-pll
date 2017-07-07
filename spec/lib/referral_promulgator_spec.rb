require 'rails_helper'

describe ReferralPromulgator do
  it 'populates special referrals' do
    expect { ReferralPromulgator.new([:test]).promulgate! }.to change { SpecialReferral.count }.by(2)
  end

  it 'populates default values' do
    ReferralPromulgator.new([:test]).promulgate!
    expect(Referral.pluck(:description).uniq).to eq ["defaultDescription"]
  end

  it 'does not overwrite existing referrals' do
    ReferralPromulgator.new([:test]).promulgate!
    expect { ReferralPromulgator.new([:test]).promulgate! }.to_not change { SpecialReferral.count }
  end
end
