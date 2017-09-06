require 'rails_helper'

describe CrossCheck do
  let(:assessment) {create(:assessment)}

  before do
    subject.assessment = assessment
    subject.save!
  end

  describe '#next_step_for' do
    it 'returns the next step name' do
      expect(subject.next_step_for(:details)).to eq 'info'
    end

    it 'step not found' do
      expect { subject.next_step_for('nothing') }.to raise_error(ArgumentError)
    end

    it 'last step passed' do
      expect(subject.next_step_for('actions')).to eq nil
    end

    describe "when assessment issue county is not known" do
      it "skips the residence page" do
        i_dont_know_county_code = '55e4fc7107115758'
        node = create(:node, is_county: true, title: 'I don\'t know', code: i_dont_know_county_code)
        create(:assessment_node, assessment: assessment, node: node)

        expect(subject.next_step_for(:deadlines)).to eq 'county_select'
      end
    end
  end

  describe '#previous_step_for' do
    it 'returns the previous step name' do
      expect(subject.previous_step_for(:info)).to eq 'details'
    end

    it 'step not found' do
      expect { subject.previous_step_for('nothing') }.to raise_error(ArgumentError)
    end

    it 'last step passed' do
      expect(subject.previous_step_for('start')).to eq nil
    end
  end
end
