require 'rails_helper'

describe AssessmentsMailer do
  let(:assessment) { create(:assessment) }

  describe "#show" do
    it "sends an email the case worker and bccs the assessment reviewer from PLL" do
      allow(ENV).to receive(:[]).with("SASS_PATH")
      allow(ENV).to receive(:[]).with("ASSESSMENT_MAIL_BCC").and_return("sacha@example.com")

      email = AssessmentsMailer.show(
        assessment,
        to: "caseworker@example.com",
        cross_check: true
      )

      expect(email.from).to eq ['no-reply@projectlegallink.org']
      expect(email.to).to eq ['caseworker@example.com']
      expect(email.bcc).to eq ['sacha@example.com']
      expect(email.subject).to eq "Summary assessment ##{assessment.reference_id}"
    end
  end

  it 'does not send an email to PLL if not this is not a cross check creation' do
    allow(ENV).to receive(:[]).with("SASS_PATH")
    allow(ENV).to receive(:[]).with("ASSESSMENT_MAIL_BCC").and_return("sacha@example.com")

    email = AssessmentsMailer.show(
      assessment,
      to: "client@example.com"
    )

    expect(email.from).to eq ['no-reply@projectlegallink.org']
    expect(email.to).to eq ['client@example.com']
    expect(email.bcc).to be_empty
  end
end
