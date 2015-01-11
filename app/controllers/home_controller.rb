class HomeController < ApplicationController

  skip_before_filter :verify_authenticity_token
  include CommonTool

  def index
    if user_signed_in?
    	if session["next_path_credentials"] && session["next_path_credentials"]["type"] == 'website'
        redirect_to "/member/campaigns/web"
      elsif
        redirect_to "/member/campaigns/mobile"
      end
    end
#	redirect_to "/member/campaigns/web"
  end

  def setup
    @response_hash = Hash.new
    if params[:type] == 'website'
      user = add_or_retrieve_user(params[:email])
      logger.error "Inspecing user -> #{user.inspect}"
      if user == "already exists"
        session[:back] = true
        redirect_to :back
        return
      end
      if user != nil
        website = add_or_update_website(user.id,params[:website])
        if website != false
          web_campaign = create_or_update_web_campaign(website.id,user.id)
          if web_campaign != false
            @response_hash["website_id"] = website.id
            @response_hash["website_key"] = website.key
            @response_hash["campaign_id"] = web_campaign.id
            @response_hash["type"] = 'website'
            @response_hash["user_id"] = user.id
            @response_hash["email"] = user.email
            # render :partial => "/home/web_setup" ,:locals => {:website_id => website.id,:website_key=>website.key}
          
          end
        end
      end
    elsif params[:type]='mobile'
      user = add_or_retrieve_user(params[:email])
      if user == "already exists"
        session[:back] = true
        redirect_to :back
        return
      end
      if user != nil
        mobile_app = add_or_update_apps(user.id,params[:mobile])
        if mobile_app != false
          mobile_campaign = create_or_update_mobile_campaign(mobile_app.id,user.id)
          if mobile_campaign != false
            @response_hash["app_key"] = mobile_app.key
            @response_hash["campaign_id"] = mobile_campaign.id
            @response_hash["type"] = 'mobile'
            @response_hash["user_id"] = user.id
            @response_hash["email"] = user.email
            #render :partial => "/home/mobile_setup"\
            logger.error " "
          end
        end
      end
    end
  end

  def campaign
  end

  def how_it_works
  end

  def pricing
  end

  def privacy
  end

  def terms_and_conditions
  end

	def test_action
		
	end
	
  def send_code_via_email
    begin
      user = User.find(params[:user_id])
      if !user.blank?
        if user.code_sharing_mails == nil
          user.code_sharing_mails = ["#{params[:email]}"]
          user.save
        else
          user.code_sharing_mails[user.code_sharing_mails.size] = params[:email]
          user.save
        end
        _sent = send_email(user.email)
        #   logger.error " Email is sent or not -> _sent = #{_sent}"
        render :text => 'sent' if _sent == 1
        render :text => 'error' if _sent == 0
      end
    rescue Exception => e
      logger.error "Error while saving Email in DB = #{e.to_s}"
    end
  end

  def create_web_widget
    if params["widget_type"] == "notification"
      _web = WebNotification.find_by_web_campaign_id(params["camp_id"])
    elsif params["widget_type"] == "coupon"
      _web = WebCoupon.find_by_web_campaign_id(params["camp_id"])
    elsif params["widget_type"] == "feedback"
      _web = WebFeedback.find_by_web_campaign_id(params["camp_id"])
    end
    _web_campaign = WebCampaign.where("id = #{params["camp_id"]}").last
    if _web.blank?
      logger.error "In create_widget -> if web is blank"
      if params["widget_type"] == "notification"
        _web = WebNotification.new
        model_name = 'WebNotification'
      elsif params["widget_type"] == "coupon"
        #          _web = WebCoupon.new
        model_name = 'WebCoupon'
        _web_campaign.model_name = model_name
        _web = save_coupon_campaign_web(_web_campaign)
      elsif params["widget_type"] == "feedback"
        _web = WebFeedback.new
        model_name = 'WebFeedback'
      end
      _web.user_id = params["user_id"]
      _web.web_campaign_id = params["camp_id"]
      _web.is_active = 0
      _web.save
      #   _web_campaign = WebCampaign.where("id = #{params["camp_id"]}").last
      _web_campaign.model_id = _web.id
      _web_campaign.model_name = model_name
      _web_campaign.title = params["widget_type"].capitalize
      _web_campaign.save
      hash = Hash.new
      hash["type"] = 'website'
      hash["id"] = _web_campaign.id
      hash["model_name"] = model_name
      hash["model_id"] = _web.id
      session["next_path_credentials"] = hash
      return 'true'
    else
      logger.error "In create_widget -> if web is not blank"
      #  _web_campaign = WebCampaign.where("id = #{params["camp_id"]}").last
      hash = Hash.new
      hash["type"] = 'website'
      hash["id"] = _web_campaign.id
      hash["model_name"] = _web_campaign.model_name
      hash["model_id"] = _web_campaign.id
      session["next_path_credentials"] = hash
      #render :text => 'true'
      return 'true'
    end
  end
=begin
  def create_mobile_widget
    if params["widget_type"] == "notification"
      _mobile = MobileNotification.find_by_mobile_campaign_id(params["camp_id"])
    elsif params["widget_type"] == "coupon"
      _mobile = MobileCoupon.find_by_mobile_campaign_id(params["camp_id"])
    elsif params["widget_type"] == "feedback"
      _mobile = MobileFeedback.find_by_mobile_campaign_id(params["camp_id"])
    end
    _mobile_campaign = MobileCampaign.where("id = #{params["camp_id"]}").last
    logger.error ">>>>>_mobile_campaign >>> #{_mobile_campaign.inspect}"
    logger.error ">>> current user >>>>> #{current_user.inspect}"
    if _mobile.blank?
      logger.error "In create_widget -> if mobile is blank"
      if params["widget_type"] == "notification"
        model_name = 'MobileNotification'
        _mobile_campaign.model_name = model_name
        #_mobile = MobileNotification.new
        _mobile = save_notification_campaign_mobile(_mobile_campaign)
          
      elsif params["widget_type"] == "coupon"
        #_mobile = MobileCoupon.new
        model_name = 'MobileCoupon'
        _mobile_campaign.model_name = model_name
        _mobile = save_coupon_campaign_mobile(_mobile_campaign)
       
      elsif params["widget_type"] == "feedback"
        #_mobile = MobileFeedback.new
        model_name = 'MobileFeedback'
        _mobile_campaign.model_name = model_name
        _mobile = save_feedback_campaign_mobile(_mobile_campaign)
         
    end

      _mobile_campaign = MobileCampaign.where("id = #{params["camp_id"]}").last
      logger.error ">>>>>_mobile_campaign >>> #{_mobile_campaign.inspect}"
      logger.error ">>> current user >>>>> #{current_user.inspect}"
      if _mobile.blank?
        logger.error "In create_widget -> if mobile is blank"
        if params["widget_type"] == "notification"
          model_name = 'MobileNotification'
          _mobile_campaign.model_name = model_name
          #_mobile = MobileNotification.new
          _mobile = save_notification_campaign(_mobile_campaign)
          
        elsif params["widget_type"] == "coupon"
          #_mobile = MobileCoupon.new
             model_name = 'MobileCoupon'
          _mobile_campaign.model_name = model_name
          _mobile = save_coupon_campaign(_mobile_campaign)
       
        elsif params["widget_type"] == "feedback"
          #_mobile = MobileFeedback.new
           model_name = 'MobileFeedback'
          _mobile_campaign.model_name = model_name
          _mobile = save_feedback_campaign(_mobile_campaign)
         
        end
        logger.error ">>>>>> _mobile >>> #{_mobile.inspect}"
        _mobile.user_id = params["user_id"]
        #_mobile.mobile_campaign_id = params["camp_id"]
        _mobile.is_active = 0
        _mobile.save

        
      _mobile_campaign.model_id = _mobile.id
      _mobile_campaign.model_name = model_name
      _mobile_campaign.title = params["widget_type"].capitalize
      _mobile_campaign.save
      hash = Hash.new
      hash["type"] = 'mobile'
      hash["id"] = _mobile_campaign.id
      hash["model_name"] = model_name
      hash["model_id"] = _mobile.id
      session["next_path_credentials"] = hash
      #render :text => 'true'
      return 'true'
    else
      logger.error "In create_widget -> if mobile is not blank"
      #  _mobile_campaign = MobileCampaign.where("id = #{params["camp_id"]}").last
      hash = Hash.new
      hash["type"] = 'mobile'
      hash["id"] = _mobile_campaign.id
      hash["model_name"] = _mobile_campaign.model_name
      hash["model_id"] = _mobile_campaign.id
      session["next_path_credentials"] = hash
      #render :text => 'true'
      return 'true'
    end
  end
=end
  def create_widget
    if !params["type"].blank? && params["type"] == 'website'
      render :text=> create_web_widget
      return
    elsif !params[:type].blank? && params[:type] == 'mobile'
      render :text=> create_mobile_widget
      return
    end
    render :text => 'false'
    return

  end

  private
  def add_or_retrieve_user(_email)
    _user = User.find_by_email(_email)
    if _user.blank?
      begin
        logger.error "creating user"
        _user = User.new
        _user.created_at = Time.now
        _user.updated_at = Time.now
        _user.username = _email
        _user.email = params[:email]
        _random_number = rand(1000000).to_s
        _user.password = "userdelight_#{_random_number}"
        logger.error "Password created for this user is : userdelight_#{_random_number}"
        _user.password_confirmation = "userdelight_#{_random_number}"
        _user.is_active = 1
        _user.source = "home_page"
        _user.save
        return _user
      rescue Exception => e
        logger.error "Error while creating a new entry for this user in user table = #{e.to_s}"
        return nil
      end
    else
      logger.error "user found"
      return "already exists"
    end
  end

  private
  def add_or_update_website(userid,domain)
    begin
      _website = Website.find_by_domain_and_user_id(domain,userid)
      if !_website.blank?
        logger.error "Website found"
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
      data ={:email => params[:email],:website_id => _website.id,:website_key => _website.key,:type=> 'website',:sub => 'Instructions to integrate widgets in your website',:to => 'admin' }
      UserMailer.send_integration_code(data).deliver
      return _website
    rescue Exception => e
      logger.error "Error while saving data in website = #{e.to_s}"
      return false
    end
  end

  private
  def create_or_update_web_campaign(websiteID,userID)
    _web_campaign = WebCampaign.find_by_website_id(websiteID)
    if _web_campaign.blank?
      begin
        logger.error "Creating new Web Campaign"
        _web_campaign = WebCampaign.new
        _web_campaign.website_id = websiteID
        _web_campaign.is_active = 1
        _web_campaign.title = "Campaign_id_#{websiteID}"
        _web_campaign.created_at = Time.now()
        _web_campaign.updated_at = Time.now()
        _web_campaign.user_id = userID
        _web_campaign.save
        return _web_campaign
      rescue Exception => e
        logger.error "Error while saving data in web campaign = #{e.to_s}"
        return false
      end
    else
      logger.error "Updating existing web Campaign"
      return _web_campaign
    end
  end

  private
  def add_or_update_apps(userID,appNAME)
    begin
      _app = MobileApp.find_by_name_and_user_id(appNAME,userID)
      if !_app.blank?
        logger.error "APP found"
      else
        logger.error "Adding a new Mobile App ..."
        _app = MobileApp.new
        string="#{userID}"+"Android"+"#{appNAME}"
        bytes=Digest::SHA2.digest(string)
        key=Digest.hexencode(bytes).to_i(32).to_s(36)
        _app.key = key
        _app.created_at = Time.now
        _app.updated_at = Time.now
        _app.name = appNAME
        _app.user_id = userID
        _app.is_active = 1
        _app.platform = "Android"
        _app.save
      end
      data = {:email => params["email"],:mobile_key => _app.key,:type => 'mobile',:sub=>'Instructions to integrate widgets in your website',:to => 'admin'}
      UserMailer.send_integration_code(data).deliver
      return _app
    rescue Exception => e
      logger.error "Error while saving data in mbile app = #{e.to_s}"
      return false
    end
  end

  private
  def create_or_update_mobile_campaign(appID,userID)
    _mobile_campaign = MobileCampaign.find_by_mobile_app_id(appID)
    if _mobile_campaign.blank?
      begin
        logger.error "Creating new mobile Campaign"
        _mobile_campaign = MobileCampaign.new
        _mobile_campaign.mobile_app_id = appID
        _mobile_campaign.is_active = 1
        _mobile_campaign.title = "Campaign_id_#{appID}"
        _mobile_campaign.created_at = Time.now()
        _mobile_campaign.updated_at = Time.now()
        _mobile_campaign.user_id = userID
        _mobile_campaign.save
        return _mobile_campaign
      rescue Exception => e
        logger.error "Error while saving data in web campaign = #{e.to_s}"
        return false
      end
    else
      logger.error "Updating existing web Campaign"
      return _mobile_campaign
    end
  end

  private
  def send_email(admin_mail)

    if params["type"] == "website"
      subject = "Instructions to integrate widgets in your website sent by #{admin_mail}"
      data = {:email => params["email"],:website_id => params["website_id"],:type => 'website', :website_key => params["website_key"],:admin_mail=>admin_mail,:sub=>subject}
    else
      subject = "Instructions to integrate SDK in your mobile app sent by #{admin_mail}"
      data = {:email => params["email"],:mobile_key => params["mobile_key"],:admin_mail=>admin_mail,:type => 'mobile',:sub=>subject}
    end
    logger.error "inspecting data = #{data.inspect}"
    begin
      UserMailer.send_integration_code(data).deliver
      return 1
    rescue Exception => e
      logger.error "Error caught while sending mail = #{e.to_s}"
      return 0
    end
  end

end

