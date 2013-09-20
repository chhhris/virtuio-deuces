class UserMailer < ActionMailer::Base
  default from: "mr.lake@gmail.com"
    
  def signup_confirmation(user)
    @user = user
    mail to: user.email, subject: "Welcome to Virtu.io"
  end

  def invoice_email(user, invoice)
  	@user = user
  	@invoice = invoice
  	@client = @invoice.client
  	mail(:to => "#{@client.name} <#{@client.email}>", :replyto => @user.email, :subject => "Invoice from #{@user.name} - due #{@invoice.date_due}")
  end
    
end