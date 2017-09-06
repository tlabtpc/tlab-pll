require 'rails_helper'

describe Assessment do
  let!(:assessment) { create(:assessment) }

  let!(:intro_node) { create(:node, title: "new-assessment") }
  let!(:final_node) { create(:node, title: "to-referral", terminal: true) }
  let!(:county_node) { create(:node, title: "Alameda", is_county: true) }

  let!(:assessment_node) { create(:assessment_node, assessment: assessment, node: intro_node) }
  let!(:assessment_terminal_node) { create(:assessment_node, assessment: assessment, node: final_node) }

  let!(:cross_check) { create(:cross_check, assessment: assessment) }

  let!(:special_referral) { create(:special_referral) }
  let!(:primary_referral) { create(:primary_referral) }
  let!(:primary_referral_first) { create(:primary_referral) }
  let!(:secondary_referral) { create(:secondary_referral) }

  let!(:node_referral_primary) { create(:node_referral, node: final_node, referral: primary_referral, position: 1)}
  let!(:node_referral_primary_first) { create(:node_referral, node: final_node, referral: primary_referral_first, position: 0)}
  let!(:node_referral_special) { create(:node_referral, node: final_node, referral: special_referral, position: 9)}

  let!(:assessment_special_referral) { create(:assessment_referral, assessment: assessment, referral: special_referral) }
  let!(:assessment_primary_referral) { create(:assessment_referral, assessment: assessment, referral: primary_referral) }
  let!(:assessment_primary_referral_two) { create(:assessment_referral, assessment: assessment, referral: primary_referral_first) }
  let!(:assessment_secondary_referral) { create(:assessment_referral, assessment: assessment, referral: secondary_referral) }


  it "has assessment nodes" do
    expect(assessment.assessment_nodes).to eq [assessment_node, assessment_terminal_node]
  end

  it "has nodes" do
    expect(assessment.nodes).to eq [intro_node, final_node]
  end

  it "has non terminal nodes" do
    expect(assessment.non_terminal_nodes).to eq [intro_node]
  end

  it "has terminal nodes" do
    expect(assessment.terminal_nodes).to eq [final_node]
  end

  it "has a cross check" do
    expect(assessment.cross_check).to eq cross_check
  end

  it "has referrals" do
    expect(assessment.referrals).to include special_referral
    expect(assessment.referrals).to include primary_referral
    expect(assessment.referrals).to include primary_referral_first
    expect(assessment.referrals).to include secondary_referral
  end

  it 'has primary referrals' do
    expect(assessment.primary_referrals).to match_array [primary_referral, primary_referral_first]
  end

  it "has secondary referrals" do
    expect(assessment.secondary_referrals).to eq [secondary_referral]
  end

  it "has special referrals" do
    expect(assessment.special_referrals).to eq [special_referral]
  end

  describe "#featured_referrals" do
    it "includes special referrals" do
      expect(assessment.featured_referrals).to match_array [special_referral, primary_referral, primary_referral_first]
    end

    it "orders by node_referral priority" do
      expect(assessment.featured_referrals.first).to eq(primary_referral_first)
      expect(assessment.featured_referrals.last).to eq(special_referral)
    end
  end

  describe 'referral_ids=' do
    it 'builds a referral' do
      assessment.referral_ids = special_referral.id
      assessment.referral_ids = primary_referral.id
      assessment.referral_ids = secondary_referral.id
      assessment.save

      expect(assessment.referrals).to include special_referral
      expect(assessment.referrals).to include primary_referral
      expect(assessment.referrals).to include secondary_referral
    end

    it 'does not duplicate a referral' do
      expect(assessment.referrals).to include primary_referral
      expect {
        assessment.referral_ids = primary_referral.id
        assessment.save
      }.to_not change { assessment.referrals.count }
    end
  end

  describe '#to_param' do
    before do
      subject.created_at = Time.zone.local(2017, 7, 8)
      subject.id = 10
    end

    it 'should combine id + created_at' do
      expect(subject.to_param).to eq('10-20170708')
    end

    it 'should add county name if it exists' do
      subject.nodes << county_node
      expect(subject.tap(&:save).to_param).to eq('alameda-10-20170708')
    end
  end
end
