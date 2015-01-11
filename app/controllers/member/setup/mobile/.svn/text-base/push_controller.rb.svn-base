class Member::Setup::Mobile::PushController < ApplicationController
  skip_before_filter :verify_authenticity_token
  include CommonTool

  def edit
    @campaign = MobilePushNotification.find_by_id(params[:id])
    @mobile_campaign = MobileCampaign.find_by_model_name_and_model_id(@campaign.class.to_s,params[:id])

    # in case it was just deactivated, this will reactivate the campaign
    if @campaign.is_active != 1
      @campaign.update_attribute("is_active", 1)
    end

    if @mobile_campaign.is_active != 1
      @mobile_campaign.update_attribute("is_active", 1)
    end
    #arr = ['Version','App Launch Counter','User Percentage','Internet Connection','Location']
    @web_campaign_filters = MobileCampaignFilter.where("is_active=1 and category not in ('Activity','Internet Connection')")
    @web_campaign_categories = MobileCampaignFilter.select("DISTINCT category").where("is_active=1 and category not in ('Activity','Internet Connection')")
    @countries = Country.order("name")
    _website = MobileApp.find_by_id(@mobile_campaign.mobile_app_id)
    render :partial => "edit"
  end

  def create_or_update
    response_data = {}
    #    begin
    raise "Campaign details not sent" if params[:campaign].blank?
		logger.error "params sent=#{params}"

    # create a record
    if params[:campaign][:id].blank?
    	@campaign = MobilePushNotification.create(params[:campaign])
    else
      @campaign = MobilePushNotification.find(params[:campaign][:id])
      if !@campaign.blank?
        params[:campaign].delete('id')
        params[:campaign]["is_active"] = 1
        @campaign.update_attributes(params[:campaign])
        @campaign.filters = params[:filters]
        hash = Hash.new
        _start = Hash.new
        _end = Hash.new
        _start["type"] = params[:starting_type] if !params[:starting_type].blank?
        _start["date"] = params[:starting_date] if !params[:starting_date].blank?
        _start["time"] = params[:starting_time] if !params[:starting_time].blank?
        _end["type"] = params[:expiring_type] if !params[:expiring_type].blank?
        _end["date"] = params[:expiring_date] if !params[:expiring_date].blank?
        _end["time"] = params[:expiring_time] if !params[:expiring_time].blank?
        _end["interval"] = params[:expiring_interval] if !params[:expiring_interval].blank?
        _end["current_time"] = params[:expiring_current_time] if !params[:expiring_current_time].blank?
        hash["starting_time"] = _start
        hash["expiring_time"] = _end
        @campaign.scheduling = hash.to_json
        @campaign.save
      end
    end
    uuid_arr = []
    mobile_campaign_id=@campaign.mobile_campaign_id
    push_notification_msg=@campaign.main_message
    push_msg_subject=@campaign.header_message
    push_msg_activity=@campaign.activity
    #		push_msg_activity="MainActivity"
    filters_data_arr=@campaign.filters

    #	logger.error ">>>>>>>mobile_campaign_id>>>>#{mobile_campaign_id.inspect}"
    mobile_appid=MobileCampaign.find_by_id(mobile_campaign_id)
    #	logger.error ">>>>>mobile_app_id>>>>#{mobile_app_id.inspect}"
    mobile_uuid_map_ids=MobileAppUuidMap.where("mobile_app_id=#{mobile_appid.mobile_app_id}")
    #	logger.error ">>>>>>mobile_uuid_map_ids>>>>>>>#{mobile_uuid_map_ids.inspect}"
    if !mobile_uuid_map_ids.blank?
      mobile_uuid_map_ids.each do |m|
        uuid_arr << m.mobile_uuid_id
      end
    end
   	logger.error ">>>>>>>>>>>>>>>>>>>>>>>> uuid_arr >>> #{uuid_arr.inspect}"
    if !uuid_arr.blank?
      @mobileuuid_tuples = MobileUuid.where("id in (#{uuid_arr.join(',')})")
      gcm_regid_arr = []
      if !@mobileuuid_tuples.blank?
        gcm_regid_arr = validate_mobileuuid_tuples_acc_to_filters(filters_data_arr)
        logger.error "Inspecting filteres list of ids = #{gcm_regid_arr.inspect}"
      end
      if !gcm_regid_arr.blank?
        #        logger.error ">>>>>>>>>>>>gcm_regid_arr>>>>>>#{gcm_regid_arr.inspect}"
        logger.error ">>>>>>>scheduling info>>>>#{@campaign.scheduling}"
        if(params[:starting_type]=="now" and gcm_regid_arr.size<=500)
	        resp,dat = send_pushnotification(gcm_regid_arr,push_notification_msg,push_msg_subject,push_msg_activity)
          @campaign.is_active = 0
          @campaign.save
          mobile_campaign = MobileCampaign.find_by_model_name_and_model_id(@campaign.class.to_s,@campaign.id)
          mobile_campaign.is_active = 0
          mobile_campaign.save
          logger.error ">>>>>>reponse of notification resp=#{resp} and data=#{dat}"
        else
          logger.error "gcm_reg_d is blank"
        end
        response_data["status"] = "Success"
        response_data["url"] = "#{SITE_URL}/mobile/push?id=#{@campaign.mobile_campaign_id}"

        render :json => response_data.to_json, :callback => params[:callback]
        return
      end
      render :text => "NOT UUIDS FOUND"
    end
  end   

  def delete
    response_data = {}

    begin
      raise "Campaign details not sent" if params[:id].blank?

      campaign = MobilePushNotification.where("id=#{params[:id]}")
      if !campaign.blank?
        campaign.update_attribute("is_active", 0)
        campaign.mobile_campaign.update_attribute("is_active", 0)
      end

      response_data = "Deactivated"
    rescue Exception => e
      response_data = e.to_s
    end
    render :text => response_data
  end

  private
	def send_pushnotification(gcm_regid_arr,push_notification_msg,push_msg_subject,push_msg_activity)
    #		logger.error ">>>>>>arr>>>>#{gcm_regid_arr.inspect}>>>>#{push_msg_activity.inspect}>>>>"
		api_key = 'AIzaSyABfo3tF4znQCscpKL4NdE6P2rPmoRTXq4'
    headers = {"Content-Type" => "application/json",
      "Authorization" => "key=#{api_key}"}
    data = {:registration_ids =>gcm_regid_arr, :data => {:message_text => push_notification_msg,:push_msg_subject=>push_msg_subject,:push_open_activity=>push_msg_activity}}
    data = data.merge({:collapse_key => 'MSG'}) #, :delay_while_idle => true, :time_to_live => 10000})

    data = data.to_json

    url_string = "https://android.googleapis.com/gcm/send"
    url = URI.parse url_string
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    resp, dat = http.post(url.path, data, headers)
    return resp,dat

  end

  def validate_mobileuuid_tuples_acc_to_filters(admin_info_arr_val)
   
    # begin
    filtered_ids = []
    @mobileuuid_tuples.each do |end_user|
      logger.error "Vaidating user with id = #{end_user.id}"
      admin_info_arr = JSON.parse(admin_info_arr_val)
      logger.error ">>> --- insepecting admin_info_arr = #{admin_info_arr.inspect}"
      user_info_arr = []
      user_info_arr = get_current_data_of_filters(admin_info_arr,end_user)
      compared_result = 1
      #admin_info_arr.each do |filter|
      for i in 0..(admin_info_arr.size - 1)
        if user_info_arr[i] == 'percentage'
          compared_result = (rand(100) + (100 - admin_info_arr[i][2])) <= 100 ?1 :0
        else
          qual_is = admin_info_arr[i][1]
          if admin_info_arr[i][0] == 'Version code' || admin_info_arr[i][0] == 'App Launch Count' || admin_info_arr[i][0] == 'Percentage of Users'
            admin_val = (admin_info_arr[i][2]).to_i
            user_val = (user_info_arr[i]).to_i
          else
            admin_val = admin_info_arr[i][2]
            user_val = user_info_arr[i]
          end
          if qual_is == 'Is equal to'
            compared_result = (user_val == admin_val)?1:0
          elsif qual_is == 'Is not equal to'
            compared_result = (user_val != admin_val)?1:0
          elsif qual_is == 'Greater than'
            compared_result = (user_val >  admin_val)?1:0
          elsif qual_is == 'Less than'
            compared_result = (user_val <  admin_val)?1:0
          elsif qual_is == 'Greater than equal to'
            compared_result = (user_val >=  admin_val)?1:0
          elsif qual_is == 'Less than equal to'
            compared_result = (user_val <=  admin_val)?1:0
          end

        end
        if compared_result == 0 #If any of the validator results in false then we dont need to proceed furthur for this user.
          logger.error "Result in false for filter - #{admin_info_arr[i][0]}: #{admin_info_arr[i][2]} #{admin_info_arr[i][1]} #{user_info_arr[i]}"
          break
        end
      end
      if compared_result == 0 #If any of the validator results in false then do the same for next user...
        next
      else
        logger.error "This user passed all filteration test"
        filtered_ids << end_user.gcm_reg_id
      end
    end
    return filtered_ids
    #rescue Exception => e
    #  logger.error "Exception error caught in validate_filters function is : #{e.to_s}"
    #end
  end

  def get_current_data_of_filters(admin_arr,end_user)
    begin
      dup_arr = []
      j=0
      admin_arr.each do |filter|
        logger.error "#{j} Filter's name = #{filter[0]}"
        if filter[0] == 'Version code'
          dup_arr[j] = end_user.version
        elsif filter[0] == 'Percentage of Users'
          dup_arr[j] = 'percentage'
        elsif filter[0] == 'Country'
          dup_arr[j] = end_user.country
        else
          dup_arr[j] = 'client-side-handling'
        end
        j += 1
      end
    rescue Exception => e
      logger.error "Exception error caught in get_current_data_of_filters function is : #{e.to_s}"
    end
    return dup_arr
  end

  private
  def get_country_name(ip_addr)
    begin
      geoip = GeoIP.new('/var/www/EmailService/GeoLiteCity.dat')
      data = geoip.city(ip_addr)
      logger.error "country_name => #{data.country_name} for ip address => #{ip_addr}"
      return data.country_name
    rescue Exception => e
      logger.error "Excption caught while fetching county name of user in load cotroller."
    end
  end

end

