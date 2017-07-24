require 'rails_helper'

describe CodeTheNode do
  it 'adds a code to yml files' do
    CodeTheNode.add_codes!
    yml = YAML.load_file(Rails.root.join('config', 'data', 'nodes', 'test_a.yml'))
    expect(yml['records'][0]['code']).to be_present
    expect(yml['records'][1]['code']).to be_present
  end
end
