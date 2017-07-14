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
      expect(CrossCheck.previous_step_for('start')).to eq nil
    end
  end

  describe 'caseworker_first_name' do
    let(:cross_check) { build(:cross_check, caseworker_name: 'Hulk Hogan') }
    it 'displays only the first name' do
      expect(cross_check.caseworker_first_name).to eq 'Hulk'
    end
  end
end
