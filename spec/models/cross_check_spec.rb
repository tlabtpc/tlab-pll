require 'rails_helper'

describe CrossCheck do
  describe '#next_step_for' do
    it 'returns the next step name' do
      expect(subject.next_step_for(:details)).to eq 'info'
    end

    it 'step not found' do
      expect { subject.next_step_for('nothing') }.to raise_error(ArgumentError)
    end

    it 'last step passed' do
      expect(subject.next_step_for('support')).to eq nil
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
