class SnsController < ApplicationController

  def sns_endpoint
    incoming_req = request.raw_post
    inc_json = JSON.parse(incoming_req)
    
    case inc_json['Type']
    when "SubscriptionConfirmation"
      process_confirmation(inc_json)
    when "Notification"
      process_notification(inc_json)
    else
      logger.error "sns_endpoint -> Invalid incoming request"
    end

    render :text => "ok"
    return
  end

  private
  # Process SNS subscription confirmation
  def process_confirmation(incoming_req)
    request_url = incoming_req['SubscribeURL']
    url = URI.parse(request_url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url.to_s)
    response = http.request(request)
    body = response.body    
  end

  private
  # Process SNS Notification message
  def process_notification(incoming_req)
    raise "process_notification -> incoming message is blank" if incoming_req.blank?

    # let's try to parse JSON within message
    begin
    json_obj = JSON.parse(incoming_req['Message'])

    rescue Exception => e
      raise "process_notification -> incoming message is not compatible -> #{e.to_s} -> #{incoming_req.inspect}"
    end

    notification_type = json_obj["notificationType"]

    bounce_type =  json_obj["bounce"]["bounceType"]
    problem_email = json_obj["bounce"]["bouncedRecipients"]
    #if problem_email.is_a?(Array) && problem_email[0].key? ("emailAddress") && !problem_email[0]["emailAddress"].blank?
    problem_email = problem_email[0]["emailAddress"]

    u = User.find_by_email(problem_email)
    if !u.blank?
      u.update_attribute('bounce_email',1)

      up = UserPreference.find_by_user_id(u.id)
      if up.blank?
        UserPreference.create(:user_id => u.id, :email => problem_email, :error_message => "#{notification_type}|#{bounce_type}")
      end
    else
      UserPreference.create(:email => problem_email, :error_message => "#{notification_type}|#{bounce_type}")
    end
    #else
	logger.error "Error: problem_email object not correct -> #{problem_email.inspect}"
    #end
  end

end
