require 'rails_helper'

describe ApplicationHelper do
  describe 'markdown' do
    it 'renders markdown' do
      expect(markdown("# header")).to eq "<h1>header</h1>\n"
    end

    it 'caches the renderer' do
      expect(Redcarpet::Markdown).to receive(:new).once.and_call_original
      markdown("# header")
      markdown("# header")
    end
  end
end
