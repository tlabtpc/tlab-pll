require 'rails_helper'

describe 'Referral Promulgators' do
  it 'populates primary referrals' do
    expect {
      Promulgators::PrimaryReferral.new(files: [:test_primary]).promulgate!
    }.to change { Referral.count }.by(4)
  end

  it 'does not populate markdown' do
    existing = PrimaryReferral.create(code: "cccc", markdown_content: "some markdown", markdown_content_es: "el márkdown")
    expect {
      Promulgators::PrimaryReferral.new(files: [:test_primary]).promulgate!
    }.to_not change { existing.markdown_content + existing.markdown_content_es }
    expect(existing.reload.title).to eq "Primary1"
  end

  it 'populates secondary referrals' do
    expect {
      Promulgators::SecondaryReferral.new(files: [:test_secondary]).promulgate!
    }.to change { Referral.count }.by(2)
  end

  it 'populates default values' do
    Promulgators::PrimaryReferral.new(files: [:test_primary]).promulgate!
    expect(Referral.pluck(:description).uniq).to eq ["a description"]
  end

  it 'does not overwrite existing referrals' do
    Promulgators::PrimaryReferral.new(files: [:test_primary]).promulgate!
    expect { Promulgators::PrimaryReferral.new(files: [:test_primary]).promulgate! }.to_not change { SpecialReferral.count }
  end
end
