require 'rails_helper'

describe AssessmentDecorator do
  let(:assessment) {create(:assessment).decorate}

  let(:category_node) {create(:node, is_category: true, title: "Housing")}
  let(:terminal_node) {create(:node, title: "Security deposit", terminal: true)}

  describe "issue_description" do
    before(:each) do
      assessment.nodes = [category_node, terminal_node]
    end

    it "comma separates category and subcategory" do
        expect(assessment.issue_description).to eq "Housing, Security deposit"
    end
  end
end
