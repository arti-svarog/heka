class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

	def send_confirmation_mail(user)
		@user = user
		mail(:to => user.email, :subject => "Account activation")
	end

  
end
