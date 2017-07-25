require 'rails_helper'

describe CodeTheNode do
  it 'adds a code to node files' do
    CodeTheNode.add_codes!('nodes')
    yml = YAML.load_file(Rails.root.join('config', 'data', 'nodes', 'test_a.yml'))
    expect(yml['records'][0]['code']).to be_present
    expect(yml['records'][1]['code']).to be_present
  end

  it 'adds a code to referral files' do
    CodeTheNode.add_codes!('referrals')
    yml = YAML.load_file(Rails.root.join('config', 'data', 'referrals', 'test_secondary.yml'))
    expect(yml['records'][0]['code']).to be_present
    expect(yml['records'][1]['code']).to be_present
  end
end
