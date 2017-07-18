require 'rails_helper'

describe Assessment do
  let!(:assessment) { create(:assessment) }

  let!(:intro_node) { create(:node, title: "new-assessment") }
  let!(:final_node) { create(:node, title: "to-referral", terminal: true) }

  let!(:assessment_node) { create(:assessment_node, assessment: assessment, node: intro_node) }
  let!(:assessment_terminal_node) { create(:assessment_node, assessment: assessment, node: final_node) }

  let!(:cross_check) { create(:cross_check, assessment: assessment) }

  let!(:special_referral) { create(:special_referral) }
  let!(:primary_referral) { create(:primary_referral) }
  let!(:secondary_referral) { create(:secondary_referral) }

  let!(:assessment_special_referral) { create(:assessment_referral, assessment: assessment, referral: special_referral) }
  let!(:assessment_primary_referral) { create(:assessment_referral, assessment: assessment, referral: primary_referral) }
  let!(:assessment_secndary_referral) { create(:assessment_referral, assessment: assessment, referral: secondary_referral) }

  it "has assessment nodes" do
    expect(assessment.assessment_nodes).to eq [assessment_node, assessment_terminal_node]
  end

  it "has nodes" do
    expect(assessment.nodes).to eq [intro_node, final_node]
  end

  it "has non terminal nodes" do
    expect(assessment.non_terminal_nodes).to eq [intro_node]
  end

  it "has a cross check" do
    expect(assessment.cross_check).to eq cross_check
  end

  it "has referrals" do
    expect(assessment.referrals).to include special_referral
    expect(assessment.referrals).to include primary_referral
    expect(assessment.referrals).to include secondary_referral
  end

  it "has primary referrals which include special referrals" do
    expect(assessment.primary_referrals).to match_array [special_referral, primary_referral]
  end

  it "has secondary referrals" do
    expect(assessment.secondary_referrals).to eq [secondary_referral]
  end
end
