require 'rails_helper'

describe Assessment do
  let!(:assessment) { create :assessment }
  let(:terminal_node) { create :node, terminal: true }
  let!(:referral) { create :primary_referral, terminal_node_id: terminal_node.id }
  let(:node) { create :node }

  describe 'terminate_with!' do
    it 'adds a terminal node to the assessment' do
      assessment.terminate_with!(terminal_node)
      expect(assessment.reload.nodes).to include terminal_node
      expect(assessment.reload.referrals).to include referral
    end

    it 'does nothing for a non-terminal node' do
      assessment.terminate_with!(node)
      expect(assessment.reload.referrals).to be_empty
      expect(assessment.nodes).to be_empty
    end
  end
end
