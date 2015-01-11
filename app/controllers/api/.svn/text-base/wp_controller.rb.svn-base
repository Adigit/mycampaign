class Api::WpController < ApplicationController
  
  
  before_filter :set_access_header

  def notifier
    response_hash = Hash.new
    if params[:email].blank? || params[:domain].blank? #|| params[:setting].blank?
      response_hash["status"] = "Error"
      response_hash["message"] = "Required inputs - email, domain or setting not provided"
      logger.error "Inspecting json before rendering = #{response_hash.inspect}"
      render :json => response_hash.to_json, :callback => params[:callback]
    else
      _user = User.find_by_email(params[:email])
      if _user.blank?
        begin
          logger.error "creating user"
          _user = User.new
          _user.created_at = Time.now
          _user.updated_at = Time.now
          _user.username = params[:name]
          _user.email = params[:email]
          _user.password = "socialappswordpress"
          _user.password_confirmation = "socialappswordpress"
          _user.is_active = 1
          _user.source = "word_press"
          _user.save
        rescue Exception => e
          logger.error "Error while creating a new entry for this user in user table = #{e.to_s}"
          response_hash["status"] = "Error"
          response_hash["message"] = "Error while creating a new entry for this user in user table"
          logger.error "Inspecting json before rendering = #{response_hash.inspect}"
          render :json => response_hash.to_json, :callback => params[:callback]
          return
        end
      else
        logger.error "user found"
      end
      if !_user.blank?
        _website = add_or_update_website(_user.id,params[:domain])
        if _website != false
          _create_or_update_campaign = create_or_update_campaign(_website.id,_user.id,params[:title])
          if _create_or_update_campaign != false
            response_hash["_id"] = "#{_website.id}"
            response_hash["api_key"] = "#{_website.key}"
            response_hash["status"] = "Success"
          else
            response_hash["status"] = "Error"
            response_hash["message"] = "Error while creating or updating data in campaign or notification table"
          end
        else
          response_hash["status"] = "Error"
          response_hash["message"] = "Error while creating or fetching website"
        end
      end
      logger.error "Inspecting json before rendering = #{response_hash.inspect}"
      render :json => response_hash.to_json, :callback => params[:callback]
      return
    end
  end

  def add_or_update_website(userid,domain)
    begin
      _website = Website.find_by_domain_and_user_id(domain,userid)
      if !_website.blank?
        logger.error "Website found"
        return _website
      else
        logger.error "adding new entry in website"
        _website = Website.new
        string="#{userid}"+"#{domain}"
        bytes=Digest::SHA2.digest(string)
        key=Digest.hexencode(bytes).to_i(32).to_s(36)
        _website.key = key
        _website.created_at = Time.now
        _website.updated_at = Time.now
        _website.domain = domain
        _website.user_id = userid
        _website.is_active = 1
        _website.name = domain.split(".")[1]
        _website.save
      end
      return _website
    rescue Exception => e
      logger.error "Error while saving data in website = #{e.to_s}"
      return false
    end
  end

  def create_or_update_campaign(websiteID,userID,campaign_type)
    _web_campaign = WebCampaign.find_by_website_id_and_model_name(websiteID,campaign_type)
    if _web_campaign.blank?
      begin
        logger.error "Creating new Web Campaign"
        _web_campaign = WebCampaign.new
        _web_campaign.model_name = campaign_type
        _web_campaign.website_id = websiteID
        _web_campaign.is_active = 1
        _web_campaign.title = "#{campaign_type}_#{websiteID}"
        _web_campaign.created_at = Time.now()
        _web_campaign.updated_at = Time.now()
        _web_campaign.user_id = userID
        _web_campaign.save
      rescue Exception => e
        logger.error "Error while saving data in web campaign = #{e.to_s}"
        return false
      end
    else
      logger.error "Updating existing web Campaign"
    end

    if campaign_type == "WebNotification"
      status = create_or_update_notification_settings(userID,_web_campaign)
    elsif campaign_type == "WebFeedback"
      status = create_or_update_feedback_settings(userID,_web_campaign)
    elsif campaign_type == "WebCoupon"
      status = create_or_update_coupon_settings(userID,_web_campaign)
    end   
    return status
  end


  def create_or_update_coupon_settings(userID,_web_campaign)
    #Setting up coupon tool for the campaign
    _web_coupon = WebCoupon.find_by_user_id_and_web_campaign_id(userID,_web_campaign.id)
    begin
      if _web_coupon.blank?
        logger.error "Creating new entry for Web Coupon"
        _web_coupon = WebCoupon.new
        _web_coupon.user_id = userID
        _web_coupon.web_campaign_id = _web_campaign.id
        _web_coupon.created_at = Time.now
        _web_coupon.updated_at = Time.now
      else
        logger.error "Updating existing entry for Web Coupon"
      end

      #TODO: Sandeep to change this to make it work
      _web_coupon.is_active = 1
      _web_coupon.good_until_hour = params["offer_time"] if !params["offer_time"].blank?
      _web_coupon.good_until_timezone = params["time_zone"] if !params["time_zone"].blank?
      _web_coupon.good_until_date = params["offer_date"] if !params["offer_date"].blank?
      _web_coupon.coupon_code =  params["coupon_code"] if !params["coupon_code"].blank?
      _web_coupon.require_share = params["user_to_share"] if !params["user_to_share"].blank?
      _web_coupon.share_fb = params["fb_share"] if !params["fb_share"].blank?
      _web_coupon.share_twitter = params["twitter_share"] if !params["twitter_share"].blank?
      _web_coupon.tab_text = params["tab_name"] if !params["tab_name"].blank?
      _web_coupon.text_color = params["tb_txt_clr"] if !params["tb_txt_clr"].blank?
      _web_coupon.background_color = params["tb_bg_clr"] if !params["tb_bg_clr"].blank?
      _web_coupon.border_color = params["tb_bdr_clr"] if !params["tb_bdr_clr"].blank?
      _web_coupon.tab_text_drop_shadow = params["tb_txt_drop_shadow"] if !params["tb_txt_drop_shadow"].blank?
      _web_coupon.tab_alignment = params["tab_alignment"] if !params["tab_alignment"].blank?
      _web_coupon.coupon_title = params["coupon_title"] if !params["coupon_title"].blank?
      _web_coupon.coupon_description = params["coupon_desc"] if !params["coupon_desc"].blank?
      _web_coupon.redirect_url = params["redirect_url"] if !params["redirect_url"].blank?
      _web_coupon.email_name = params["from_name"] if !params["from_name"].blank?
      _web_coupon.email_address = params["email_address"] if !params["email_address"].blank?
      _web_coupon.title_background_color = params["title_bg_clr"] if !params["title_bg_clr"].blank?
      _web_coupon.title_text_color = params["title_txt_clr"] if !params["title_txt_clr"].blank?
      _web_coupon.coupon_border_color = params["cupn_bdr_clr"] if !params["cupn_bdr_clr"].blank?
      _web_coupon.coupon_background_color = params["cupn_bg_clr"] if !params["cupn_bg_clr"].blank?
      _web_coupon.coupon_text_color = params["cupn_txt_clr"] if !params["cupn_txt_clr"].blank?

       _web_coupon.save
      if _web_campaign.model_id.blank?
        _web_campaign.model_id = _web_coupon.id
        _web_campaign.save
        logger.error "Web Campaign updated with coupon model id"
      end
    rescue Exception => e
      logger.error "Error caught while saving data in web coupon = #{e.to_s}"
      return false
    end
    return true
  end

  def create_or_update_notification_settings(userID,_web_campaign)
    #Setting up notification tool for the campaign
    _web_notification = WebNotification.find_by_user_id_and_web_campaign_id(userID,_web_campaign.id)
    begin
      if _web_notification.blank?
        logger.error "Creating new entry for Web Notification"
        _web_notification = WebNotification.new
        _web_notification.user_id = userID
        _web_notification.web_campaign_id = _web_campaign.id
        _web_notification.created_at = Time.now
        _web_notification.updated_at = Time.now
      else
        logger.error "Updating existing entry for Web Notification"
      end
      _web_notification.is_active = 1
      _web_notification.message = params["message"] if !params["message"].blank?
      _web_notification.call_to_action_text = params["action_text"] if !params["action_text"].blank?
      _web_notification.call_to_action_url = params["action_url"] if !params["action_url"].blank?
      _web_notification.call_to_action_new_window = params["new_window"] if !params["new_window"].blank?
      _web_notification.allow_close_notification =  params["close"] if !params["close"].blank?
      _web_notification.fixed_position = params["fixed"] if !params["fixed"].blank?
      _web_notification.push_down_html = params["push_down"] if !params["push_down"].blank?
      _web_notification.content_alignment = params["alignment"] if !params["alignment"].blank?
      _web_notification.background_color = params["bg_c"] if !params["bg_c"].blank?
      _web_notification.border_color = params["bor_c"] if !params["bor_c"].blank?
      _web_notification.text_color = params["txt_c"] if !params["txt_c"].blank?
      _web_notification.action_background_color = params["act_bg_c"] if !params["act_bg_c"].blank?
      _web_notification.action_text_color = params["act_txt_c"] if !params["act_txt_c"].blank?
      _web_notification.action_border_color = params["act_bor_c"] if !params["act_bor_c"].blank?
      _web_notification.opacity = params["opacity"] if !params["opacity"].blank?
      _web_notification.save
      if _web_campaign.model_id.blank?
        _web_campaign.model_id = _web_notification.id
        _web_campaign.save
        logger.error "Web Campaign updated with notification model id"
      end
    rescue Exception => e
      logger.error "Error caught while saving data in web notification = #{e.to_s}"
      return false
    end
    return true
  end

  def create_or_update_feedback_settings(userID,_web_campaign)
    #Setting up notification tool for the campaign
    _web_feedback = WebFeedback.find_by_user_id_and_web_campaign_id(userID,_web_campaign.id)
    begin
      if _web_feedback.blank?
        logger.error "Creating new entry for Web Feedback"
        _web_feedback = WebFeedback.new
        _web_feedback.user_id = userID
        _web_feedback.web_campaign_id = _web_campaign.id
        _web_feedback.created_at = Time.now
        _web_feedback.updated_at = Time.now
      else
        logger.error "Updating existing entry for Web Feedback"
      end
      _web_feedback.is_active = 1
      _web_feedback.tab_text = params["tb_name"] if !params["tb_name"].blank?
      _web_feedback.background_color = params["tb_bg_clr"] if !params["tb_bg_clr"].blank?
      _web_feedback.border_color = params["tb_bdr_clr"] if !params["tb_bdr_clr"].blank?
      _web_feedback.text_color = params["tb_txt_clr"] if !params["tb_txt_clr"].blank?
      _web_feedback.title_background_color = params["title_bg_clr"] if !params["title_bg_clr"].blank?
      _web_feedback.title_text_color = params["title_txt_clr"] if !params["title_txt_clr"].blank?
      _web_feedback.form_background_color = params["frm_bg_clr"] if !params["frm_bg_clr"].blank?
      _web_feedback.form_border_color = params["form_bdr_clr"] if !params["form_bdr_clr"].blank?
      _web_feedback.form_text_color = params["form_txt_clr"] if !params["form_txt_clr"].blank?
      _web_feedback.action_background_color = params["action_bg_clr"] if !params["action_bg_clr"].blank?
      _web_feedback.action_text_color = params["action_txt_clr"] if !params["action_txt_clr"].blank?
      _web_feedback.tab_text_drop_shadow = params["drop_shadow"] if !params["drop_shadow"].blank?
      _web_feedback.tab_alignment = params["tab_align"] if !params["tab_align"].blank?
      _web_feedback.form_title = params["form_title"] if !params["form_title"].blank?
      _web_feedback.get_name =  params["ask_name"] if !params["ask_name"].blank?
      _web_feedback.get_mobile = params["ask_mobile"] if !params["ask_mobile"].blank?
      _web_feedback.get_category = params["ask_ctgry"] if !params["ask_ctgry"].blank?
      _web_feedback.get_message = params["ask_mssg"] if !params["ask_mssg"].blank?
      _web_feedback.get_rating = params["ask_rating"] if !params["ask_rating"].blank?
      _web_feedback.get_screenshot = params["ask_screenshot"] if !params["ask_screenshot"].blank?
      _web_feedback.thank_you_message = params["thnk_msg"] if !params["thnk_msg"].blank?
      _web_feedback.send_to_email = params["send_to_email"] if !params["send_to_email"].blank?
      _web_feedback.save
      if _web_campaign.model_id.blank?
        _web_campaign.model_id = _web_feedback.id
        _web_campaign.save
        logger.error "Web Campaign updated with feedback model id"
      end
    rescue Exception => e
      logger.error "Error caught while saving data in web notification = #{e.to_s}"
      return false
    end
    return true
  end

  def set_access_header
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
end

