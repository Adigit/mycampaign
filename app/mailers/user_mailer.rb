class UserMailer < ActionMailer::Base
  default from: "noreply@usersdelight.com"
  
  def send_integration_code(data)
    @subject = data[:sub]
    @recipient = data[:email]
    @data = data
    @from = "UsersDelight <noreply@usersdelight.com>"
    @sent_on = Time.now
    mail(to: @recipient, subject: @subject)
  end

  def welcome_email(data)
    @subject = 'Welcome to UserDelight.com'
    @data = data
    @recipient = data[:email]
    @from = "UsersDelight <noreply@usersdelight.com>"
    @sent_on = Time.now
    mail(to: @recipient, subject: @subject)  
  end

  #Added by Aashish - to send email of web coupons
  def send_coupon_code(body)
    @coupon_code = "#{body[:ccode]}"
    @end_date = "#{body[:end_date]}"
    @end_time = "#{body[:end_time]}"
    @coupon_link = "#{body[:link]}"
    @subject    = "#{body[:sub]}"
    @body = body
    @recipients = "#{body[:email]}"
    if !body[:send_email].blank?
      @reply_to = "#{body[:send_email]}"
    end
    if !body[:send_name].blank?
    @from = "#{body[:send_name]} <noreply@usersdelight.com>"
    else
    @from = "UsersDelight <noreply@usersdelight.com>"
    end
    @sent_on    = Time.now
    mail(to: @recipients ,subject: @subject)
  end

  #Added by Aashish - To send Feedback details
  def send_feedback(body)
   @subject    = "A new Feedback by your website user"
   @body = body
   @recipients = "#{body['send_email']}"
   @data = body
   @from = "UsersDelight <noreply@usersdelight.com>"
   @cc = body["email"]
   @sent_on    = Time.now
   mail(to: @recipients , cc: @cc ,subject: @subject)
  end

end
