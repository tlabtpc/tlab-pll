require 'rails_helper'

describe NextLocation do
  include Rails.application.routes.url_helpers

  describe '.resolve' do
    let!(:assessment) { create :assessment }
    let!(:start_node) { node }

    before do
      assessment.nodes << start_node
    end

    context 'there no special cases' do
      it 'returns the nodes/show path' do
        expect(resolved_path(start_node)).to eq (node_path(start_node))
      end
    end

    context 'node is a terminal node' do
      let!(:terminal_node) { node start_node, terminal: true }

      before do
        assessment.nodes << terminal_node
      end

      context 'assessment has referrals' do
        let!(:referral) { create :primary_referral }

        before do
          assessment.referrals << referral
        end

        it 'returns the assessment referrals index path' do
          expect(resolved_path(terminal_node)).to eq assessment_referrals_path
        end
      end

      context 'assessment has no referrals' do
        it 'returns the cross check path' do
          expect(resolved_path(terminal_node)).to eq details_cross_checks_path
        end
      end
    end
  end

  def resolved_path(node)
    described_class.resolve(assessment, node)
  end

  def node(parent = nil, **args)
    create :node, parent_node_id: parent&.id, **args
  end
end
