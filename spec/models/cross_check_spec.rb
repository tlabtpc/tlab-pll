require 'rails_helper'

describe CrossCheck do
  describe '.next_step_for' do
    it 'returns the next step name' do
      expect(CrossCheck.next_step_for(:details)).to eq 'info'
    end

    it 'step not found' do
      expect { CrossCheck.next_step_for('nothing') }.to raise_error(ArgumentError)
    end

    it 'last step passed' do
      expect(CrossCheck.next_step_for('support')).to eq nil
    end
  end

  describe '.previous_step_for' do
    it 'returns the previous step name' do
      expect(CrossCheck.previous_step_for(:info)).to eq 'details'
    end

    it 'step not found' do
      expect { CrossCheck.previous_step_for('nothing') }.to raise_error(ArgumentError)
    end

    it 'last step passed' do
      expect(CrossCheck.previous_step_for('new')).to eq nil
    end
  end
end
