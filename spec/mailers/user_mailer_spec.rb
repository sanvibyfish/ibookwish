require "spec_helper"

describe UserMailer do
  describe "remind" do
    let(:mail) { UserMailer.remind }

    it "renders the headers" do
      mail.subject.should eq("Remind")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
