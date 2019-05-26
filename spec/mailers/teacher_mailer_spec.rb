require "rails_helper"

RSpec.describe TeacherMailer, type: :mailer do
  describe "password_reset" do
    teacher = create(:teacher)
    teacher.reset_token = Teacher.new_token

    it "renders the headers" do
      expect(mail.subject).to eq("Password reset")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
