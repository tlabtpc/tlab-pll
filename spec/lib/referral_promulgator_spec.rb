require 'rails_helper'

describe 'Referral Promulgators' do
  it 'populates primary referrals' do
    expect {
      Promulgators::Referral.new(files: [:test_primary]).promulgate!
    }.to change { Referral.count }.by(4)
  end

  it 'does not populate markdown ever' do
    existing = PrimaryReferral.create(code: "cccc", markdown_content: "some markdown", markdown_content_es: "el márkdown")
    expect {
      Promulgators::Referral.new(files: [:test_primary]).promulgate!
    }.to_not change { existing.markdown_content + existing.markdown_content_es }
    expect(existing.reload.title).to eq "Primary1"
  end

  it 'does not overwrite descriptions, titles or unique ids from prod' do
    Promulgators::Referral.new(files: [:test_primary]).promulgate!

    referral = PrimaryReferral.where(code: "cccc").first

    referral.update(
      description: "admin description",
      title: "admin given title",
      unique_identifier: "admin unique id"
    )

    expect(referral.reload.title).to eq "admin given title"

    expect {
      Promulgators::Referral.new(files: [:test_primary]).promulgate!
    }.to_not change { referral.title + referral.description + referral.unique_identifier}

    expect(referral.reload.title).to eq "admin given title"
  end

  it 'populates secondary referrals' do
    expect {
      Promulgators::SecondaryReferral.new(files: [:test_secondary]).promulgate!
    }.to change { Referral.count }.by(2)
  end

  it 'populates default values' do
    Promulgators::Referral.new(files: [:test_primary]).promulgate!
    expect(Referral.pluck(:description).uniq).to match_array ["a description", "template desc"]
  end

  it 'does not overwrite existing referrals' do
    Promulgators::Referral.new(files: [:test_primary]).promulgate!
    expect { Promulgators::Referral.new(files: [:test_primary]).promulgate! }.to_not change { SpecialReferral.count }
  end
end
