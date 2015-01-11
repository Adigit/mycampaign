require "spec_helper"

describe UserMailer do
	describe "welcome email" do
		let(:data) do
			{:email =>"aditya@socialappshq.com", :test => "aditya "}
		end
		let(:mail) {UserMailer.welcome_email(data)}
		it "renders the subject" do 
			expect(mail.subject).to eql('Welcome to UserDelight.com')
		end
		it "renders the receiver email" do
			expect(mail.to).to eql([data[:email]])
		end
		it "renders the sender email" do
			expect(mail.from).to eql(["noreply@usersdelight.com"])
		end
	end
end
