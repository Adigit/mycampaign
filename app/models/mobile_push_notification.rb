class MobilePushNotification
  include Mongoid::Document
  belongs_to :mobile_campaign
#  attr_protected :id
  validates_uniqueness_of :mobile_campaign_id
  serialize :scheduling

  def self.check_for_messages
    all_push_campaigns = MobilePushNotification.where("is_active=1")
    logger.error " ----- CRONTAB intializing MobilePushNotification to push messages >"
    send_mssgs_of_ids = Array.new
    if !all_push_campaigns.blank?
      all_push_campaigns.each do |campaign|
        if !campaign.scheduling.blank?
          _schedule = JSON.parse(campaign.scheduling)
          #logger.error "Campaign scheduled as : #{_schedule.inspect}"
          if _schedule["starting_time"]["type"] == "now"
            send_mssgs_of_ids << campaign
            #logger.error "when starting date is now, pushing campaign id in send_mssg lists=#{send_mssgs_of_ids.inspect}"
          elsif _schedule["starting_time"]["type"] == "time"
            #logger.error "When starting type is time"
            current_date = (Time.now().to_s).split(" ")[0]           
            #logger.error "current_date = #{current_date}"
            starting_date = _schedule["starting_time"]["date"]
            #logger.error "current_date = #{current_date} , starting_date =#{starting_date}"
            if _schedule["starting_time"]["time"].split(" ")[3] == "UTC"
              current_hour = (Time.now().to_s).split(" ")[1].split(":")[0].to_i
              current_minute = (Time.now().to_s).split(" ")[1].split(":")[1].to_i
            else
              #logger.error "when time save as IST"
              current_minute = ((Time.now().to_s.split(" ")[1].split(":")[1]).to_i + 30)%60 #adding 30 mintues then taking remainder with 60
              current_hour = (Time.now().to_s.split(" ")[1].split(":")[0]).to_i + 5 + ((Time.now().to_s.split(" ")[1].split(":")[1]).to_i + 30)/60 #adding 5 plus dividend of minutes divided by 60
            end            
            if _schedule["starting_time"]["time"].split(" ")[2] == "PM"
              starting_hour = _schedule["starting_time"]["time"].split(" ")[0].to_i + 12
            else
              starting_hour = _schedule["starting_time"]["time"].split(" ")[0].to_i
            end
            starting_minute = _schedule["starting_time"]["time"].split(" ")[1].to_i
            logger.error "current_date = #{current_date} , starting_date =#{starting_date}, current_hour =#{current_hour}, starting_hour = #{starting_hour}, current_minute = #{current_minute}, starting_minute = #{starting_minute} "
            if current_date > starting_date || (current_date == starting_date && starting_hour < current_hour) || (current_date == starting_date && starting_hour == current_hour && starting_minute <= current_minute)
              #SEND NOTIFICATION -----------------------------------------------------
              send_mssgs_of_ids << campaign
              logger.error "This campaign passed the scheduling test for current time, hence pushin it in send_mssg_list=#{send_mssgs_of_ids.inspect}"
            end
          end
          if _schedule["expiring_time"]["type"] == "time"
            expiring_date = _schedule["expiring_time"]["date"]
            if _schedule["expiring_time"]["time"].split(" ")[3] == "UTC"
              current_hour = Time.now().to_s.split(" ")[1].split(":")[0]
              current_minute = Time.now().to_s.split(" ")[1].split(":")[1]
            else
              current_minute = (Time.now().to_s.split(" ")[1].split(":")[1].to_i + 30)%60 #adding 30 mintues then taking remainder with 60
              current_hour = (Time.now().to_s.split(" ")[1].split(":")[0].to_i) + 5 + (Time.now().to_s.split(" ")[1].split(":")[1].to_i + 30)/60 #adding 5 plus dividend of minutes divided by 60
            end
            if _schedule["expiring_time"]["time"].split(" ")[2] == "PM"
              expiring_hour = _schedule["expiring_time"]["time"].split(" ")[0].to_i + 12
            else
              expiring_hour = _schedule["expiring_time"]["time"].split(" ")[0].to_i
            end
            expiring_minute = _schedule["expiring_time"]["time"].split(" ")[1].to_i
            logger.error "When expiring type is 'TIME' : current_date = #{current_date} , expiring_date =#{expiring_date}, current_hour =#{expiring_hour}, expiring_hour = #{expiring_hour}, current_minute = #{current_minute}, expiring_minute = #{expiring_minute} "
            if current_date > expiring_date || (current_date == expiring_date && expiring_hour < current_hour) || (current_date == expiring_date && expiring_hour == current_hour && expiring_minute <= current_minute)
              #DEACTIVATE CAMPAIGN ----------------------------------------------------------------
              logger.error "DEACTIVATING CAMPAIGN ---------------------------"
              campaign.is_active = 0
              campaign.save
              mobile_campaign = MobileCampaign.find_by_model_name_and_model_id(campaign.class.to_s,campaign.id)
              mobile_campaign.is_active = 0
              mobile_campaign.save
            end
          elsif _schedule["expiring_time"]["type"] == "interval"
            interval_value = _schedule["expiring_time"]["interval"].split(" ")[0].to_i
            interval_parameter = _schedule["expiring_time"]["interval"].split(" ")[1]
            current_time_in_secs = Time.now.to_i
            time_when_campaign_starts = _schedule["expiring_time"]["current_time"].to_i
            logger.error "When expiring time is 'INTERVAL' : interval_value = #{interval_value} ,interval_parameter = #{interval_parameter} ,current_time_in_secs = #{current_time_in_secs} ,time_when_campaign_starts = #{time_when_campaign_starts}"
            if interval_parameter == "hour"
              if (current_time_in_secs - time_when_campaign_starts) >= (interval_value*3600)
                ## stop campaign
                logger.error "DEACTIVATING CAMPAIGN ---------------------------"
                campaign.is_active = 0
                campaign.save
                mobile_campaign = MobileCampaign.find_by_model_name_and_model_id(campaign.class.to_s,campaign.id)
                mobile_campaign.is_active = 0
                mobile_campaign.save
              end
            else
              if (current_time_in_secs - time_when_campaign_starts) >= (interval_value*86400)
                ## stop campaign
                logger.error "DEACTIVATING CAMPAIGN ---------------------------"
                campaign.is_active = 0
                campaign.save
                mobile_campaign = MobileCampaign.find_by_model_name_and_model_id(campaign.class.to_s,campaign.id)
                mobile_campaign.is_active = 0
                mobile_campaign.save
              end
            end
          end
        end
      end
    end
    return send_mssgs_of_ids
  end

  def self.send_push_notifications_to 
    list_of_campaigns_to_send = check_for_messages()
    list_of_campaigns_to_send.each do |campaign|
      mobile_appid=MobileCampaign.find(campaign.id)
      mobile_uuid_map_ids=MobileAppUuidMap.where("mobile_app_id=#{mobile_appid.mobile_app_id}")
      uuid_arr = []
      if !mobile_uuid_map_ids.blank?
        mobile_uuid_map_ids.each do |m|
          uuid_arr << m.mobile_uuid_id
        end
      end
      if !uuid_arr.blank?
        @mobileuuid_tuples = MobileUuid.where("id in (#{uuid_arr.join(',')})")
        gcm_regid_arr = []
        if !@mobileuuid_tuples.blank?
          filters_data_arr = campaign.filters
          filters_data_arr = JSON.parse(filters_data_arr) if !filters_data_arr.blank?
          if !filters_data_arr.blank?
            gcm_regid_arr = validate_mobileuuid_tuples_acc_to_filters(filters_data_arr)
          else
            @mobileuuid_tuples.each do |tuple|
              gcm_regid_arr << tuple.gcm_reg_id
            end
          end
        end
        if !gcm_regid_arr.blank?
          push_notification_msg = campaign.main_message
          push_msg_subject = campaign.header_message
          push_msg_activity = campaign.activity
          if(gcm_regid_arr.size <= 500)
            resp,dat = send_pushnotification(gcm_regid_arr,push_notification_msg,push_msg_subject,push_msg_activity)
            campaign.is_active = 0
            campaign.save
            mobile_campaign = MobileCampaign.find_by_model_name_and_model_id(campaign.class.to_s,campaign.id)
            mobile_campaign.is_active = 0
            mobile_campaign.save
          else
            logger.error "gcm_reg_d is blank"
          end
          response_data["status"] = "Success"
          response_data["url"] = "#{SITE_URL}/mobile/push?id=#{campaign.mobile_campaign_id}"
          render :json => response_data.to_json, :callback => params[:callback]
          return
        end
        render :text => "NOT UUIDS FOUND"
      end
    end
  end

  def self.validate_mobileuuid_tuples_acc_to_filters(admin_info_arr)
    begin
      filtered_ids = []
      @mobileuuid_tuples.each do |end_user|
        user_info_arr = []
        user_info_arr = get_current_data_of_filters(admin_info_arr,end_user)
        compared_result = 1
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
          #logger.error "This user passed all filteration test"
          filtered_ids << end_user.gcm_reg_id
        end
      end
      #logger.error "End of validate_mobileuuid_tuples_acc_to_filters."
      return filtered_ids
    rescue Exception => e
      logger.error "Exception error caught in validate_filters function is : #{e.to_s}"
    end
  end

  def self.get_current_data_of_filters(admin_arr,end_user)
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

  def self.send_pushnotification(gcm_regid_arr,push_notification_msg,push_msg_subject,push_msg_activity)
    logger.error "In Send Push Notification Function"
    api_key = 'AIzaSyABfo3tF4znQCscpKL4NdE6P2rPmoRTXq4'
    headers = {"Content-Type" => "application/json",
      "Authorization" => "key=#{api_key}"}
    data = {:registration_ids =>gcm_regid_arr, :data => {:message_text => push_notification_msg,:push_msg_subject=>push_msg_subject,:push_open_activity=>push_msg_activity}}
    data = data.merge({:collapse_key => 'MSG'}) #, :delay_while_idle => true, :time_to_live => 10000})

    data = data.to_json
    #logger.error "In send_pushnotification data=#{data.inspect}"
    url_string = "https://android.googleapis.com/gcm/send"
    url = URI.parse url_string
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    resp, dat = http.post(url.path, data, headers)
    logger.error "End of 'send_pushnotification'"
    return resp,dat
  end
end

