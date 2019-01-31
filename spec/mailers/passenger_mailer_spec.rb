require "rails_helper"

RSpec.describe PassengerMailer, type: :mailer do
  describe "new_passenger" do
    let(:mail) { PassengerMailer.new_passenger }

    it "renders the headers" do
      expect(mail.subject).to eq("New passenger")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
