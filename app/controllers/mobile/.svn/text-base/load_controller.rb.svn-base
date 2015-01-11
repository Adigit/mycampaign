class Mobile::LoadController < ApplicationController
  require 'json'
  

  before_filter :set_access_header
  def index
    response_hash = Hash.new()
#    begin
      # parse json object into variable
      response, app = process_incoming(params)
      #		logger.error ">>>>>process_incoming response>>>>>#{response.inspect}"
      #		logger.error ">>>>>process_incoming app>>>>>#{app.inspect}"
      # add mobile uuid infromation into uuid table
      add_uuid_to_db(response, app)
      # get live campaigns

      res = JSON.parse(params[:JsonObject])
      counter = res["app_launches_counter"].to_i
      campaigns = MobileCampaign.find_all_by_mobile_app_id_and_is_active(app.id, 1)

      raise "No live campaigns found" if campaigns.blank?
      campaigns.each {|c|
        #        logger.error "Inspecting response hash = #{response_hash.inspect}"
        if !response_hash.key?("#{c.model_name}")
          obj = c.model_name.constantize.find_by_id(c.model_id)
			logger.error ">>>model name=#{c.model_name}"
          if !obj.blank? && c.model_name!="MobilePushNotification"
            #logger.error "campaign running with configuration as : #{obj.inspect}"
            validate_filters_flag = 1
            if !obj.filters.blank?
              validate_filters_flag = validate_filters(obj.filters)
              logger.error "validate_filters_flag results in = #{validate_filters_flag}"
            end
            if validate_filters_flag == 1
              if !obj.filters.blank?
                arr = Array.new
                _filters = JSON.parse(obj.filters)
                _filters.each do |filter|
                  arr << filter if filter[0] != 'App Launch Count' && filter[0] != 'Version code' && filter[0] != 'Country' && filter[0] != 'Percentage of Users'
                logger.error "arr = #{arr.inspect} and filter = #{filter.inspect}"
                end
                obj.filters = arr
              logger.error "Inspecting obj after filteration part = #{obj.inspect}"
              end
              response_hash["#{c.model_name}"] = obj
            end

          end
        end
      }
      response_hash["status"] = "Success"
#    rescue Exception => e
=begin
      response_hash["status"] = "Error"
      response_hash["message"] = e.to_s
      logger.error $!, $!.backtrace
=end
#    end
    logger.error ">>>>>>>>>>response_hash>>>>> #{response_hash.inspect}"
    render :json => response_hash.to_json, :callback => params[:callback]
  end


  def validate_filters(admin_info_arr)
    begin
      logger.error "In validate_filters, inspecting admin_info_arr  = #{admin_info_arr.inspect}"
      admin_info_arr = JSON.parse(admin_info_arr)
      user_info_arr = []
      user_info_arr = get_current_data_of_filters(admin_info_arr)
      compared_result = 1
      logger.error "Current values array = #{user_info_arr.inspect}"
      #admin_info_arr.each do |filter|
      for i in 0..(admin_info_arr.size - 1)
        logger.error "current value = #{user_info_arr[i]} and qualifier is = #{admin_info_arr[i][1]} and admin value is #{admin_info_arr[i][2]}"
        if user_info_arr[i] == 'percentage'
  				admin_val = (admin_info_arr[i][2]).to_i
          compared_result = (rand(100) + (100 - admin_val) <= 100)?1:0
        elsif user_info_arr[i] != 'client-side-handling'
          qual_is = admin_info_arr[i][1]
          if admin_info_arr[i][0] == 'Version code' || admin_info_arr[i][0] == 'App Launch Count' || admin_info_arr[i][0] == 'Percentage of Users'
            admin_val = (admin_info_arr[i][2]).to_i
          else
            admin_val = admin_info_arr[i][2]
          end
          if qual_is == 'Is equal to'
            compared_result = (user_info_arr[i] == admin_val)?1:0
          elsif qual_is == 'Is not equal to'
            compared_result = (user_info_arr[i] != admin_val)?1:0
          elsif qual_is == 'Greater than'
            compared_result = (user_info_arr[i] >  admin_val)?1:0
          elsif qual_is == 'Less than'
            compared_result = (user_info_arr[i] <  admin_val)?1:0
          elsif qual_is == 'Greater than equal to'
            compared_result = (user_info_arr[i] >=  admin_val)?1:0
          elsif qual_is == 'Less than equal to'
            compared_result = (user_info_arr[i] <=  admin_val)?1:0
          end
        end
        logger.error "Result after comparing is = #{compared_result}"
        if compared_result == 0
          return 0
        end
      end
    rescue Exception => e
      logger.error "Exception error caught in validate_filters function is : #{e.to_s}"
    end
    return 1
  end

  def get_current_data_of_filters(arr)
    user_data = JSON.parse(params["JsonObject"])
    dup_arr = []
    begin
      j=0
      arr.each do |filter|
        logger.error "#{j} Filter's name = #{filter[0]}"
        if filter[0] == 'Version code'
          dup_arr[j] = user_data["logs_payload"]["params"]["version_code"] ##TODO: change according to the params ...
        elsif filter[0] == 'App Launch Count'
          dup_arr[j] = user_data["app_launches_counter"]
        elsif filter[0] == 'Country'
          dup_arr[j] = user_data["logs_payload"]["params"]["country"]
        elsif filter[0] == 'Percentage of Users'
          dup_arr[j] = 'percentage'
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

=begin
  def index
    begin
      # parse json object into variable
      response, app = process_incoming(params)
      # add mobile uuid infromation into uuid table
      add_uuid_to_db(response, app)
      response_hash   = Hash.new()

      screen_size = response["logs_payload"]["params"]["screen_size"]
      var_hash = {}
      exp_hash = {}

      records = Variation.connection.execute("SELECT variations.name as var_name, experiments.name as exp_name, variations.id as id,variations.percentage, variations.app_version_code, variations.internet_connection_type as per FROM variations INNER JOIN experiments ON variations.experiment_id=experiments.id and experiments.app_id=#{app.id} and variations.screen_max >= #{screen_size} and variations.screen_min <= #{screen_size} and experiments.is_active = 1 and variations.is_active = 1 order by exp_name")

      record = Variation.connection.execute("SELECT variations.name as var_name, experiments.name as exp_name, variations.id as id,variations.percentage, variations.app_version_code, variations.internet_connection_type as per FROM variations INNER JOIN experiments ON variations.experiment_id=experiments.id and experiments.app_id=#{app.id} and variations.screen_max >= #{screen_size} and variations.screen_min <= #{screen_size} and experiments.is_active = 1 and variations.is_active = 1 order by exp_name limit 1")

      heatmap_data = Heatmap.find(:all, :conditions => "app_id=#{app.id} and is_active=1")

      navigation_data = Navigation.find_by_app_id_and_is_active(app.id, 1)

      upgrade_popup_data = UpgradePopup.find_by_app_id_and_is_active(app.id, 1)

      usability_test_data = UsabilityTest.find(:all, :conditions => "app_id=#{app.id} and is_active=1")

      count = records.num_rows

      record.each { |r|
        @x = r[1]
      }

      x = @x
      count = records.num_rows

      # add AB testing data to response hash
      records.each { |a|
        if a[1] != x
          exp_hash["#{x}"] = var_hash
          var_hash = Hash.new()
        end

        sub_hash = {}
        sub_hash["variation_id"] = a[2].to_i
        sub_hash["percentage"] = a[3].to_i
        sub_hash["version_codes"] = a[4].blank?? " " : a[4]
        sub_hash["internet_connection_type"] = a[5].blank?? " " : a[5]

        var_hash["#{a[0]}"] = sub_hash

        x = a[1]
        count = count-1

        if count == 0
          exp_hash["#{x}"] = var_hash
        end
      }

      response_hash["ab_test_data"] = exp_hash

      # add heatmap data to response hash
      if !heatmap_data.blank?
        heatmap_hash = {}
        heatmap_data.each{|hm|
          sub_hash = {}
          sub_hash["hm_id"] = hm.id
          sub_hash["test_name"] = hm.name
          sub_hash["percentage"] = hm.percentage
          sub_hash["activity_name"] = hm.activity
          sub_hash["version_codes"] = hm.app_version_code.blank?? " " : hm.app_version_code
          sub_hash["internet_connection_type"] = hm.internet_connection_type.blank?? " " : hm.internet_connection_type

          heatmap_hash["#{hm.activity}"] = sub_hash
        }

        response_hash["heatmap_data"] = heatmap_hash
        response_hash["is_heatmap_test_created"] = "true"
      else
        response_hash["is_heatmap_test_created"] = "false"
      end

      # add navigation data to response hash
      if !navigation_data.blank?
        response_hash["navigation_test_id"] = navigation_data.id
        sub_hash = {}
        sub_hash["version_codes"] = navigation_data.app_version_code.blank?? " " : navigation_data.app_version_code
        sub_hash["internet_connection_type"] = navigation_data.internet_connection_type.blank?? " " : navigation_data.internet_connection_type
        response_hash["navigation_data"] = sub_hash
      else
        response_hash["navigation_test_id"] = 0
      end

      # add upgrade popup data to response hash
      if !upgrade_popup_data.blank?
        response_hash["upgrade_popup_test_id"] = upgrade_popup_data.id
        sub_hash = {}
        sub_hash["activity_name"] = upgrade_popup_data.activity.blank?? " " : upgrade_popup_data.activity
        sub_hash["percentage"] = upgrade_popup_data.percentage
        sub_hash["version_codes"] = upgrade_popup_data.app_version_code.blank?? " " : upgrade_popup_data.app_version_code
        sub_hash["internet_connection_type"] = upgrade_popup_data.internet_connection_type.blank?? " " : upgrade_popup_data.internet_connection_type
        sub_hash["positive_btn_text"] = upgrade_popup_data.first_button_title.blank?? "Update" : upgrade_popup_data.first_button_title
        sub_hash["positive_btn_link"] = upgrade_popup_data.first_button_link.blank?? " " : upgrade_popup_data.first_button_link
        sub_hash["negative_btn_text"] = upgrade_popup_data.second_button_title.blank?? "Not Now" : upgrade_popup_data.second_button_title
        sub_hash["negative_btn_link"] = upgrade_popup_data.second_button_link.blank?? " " : upgrade_popup_data.second_button_link
        sub_hash["popup_title"] = upgrade_popup_data.header.blank?? "New version available" : upgrade_popup_data.header
        sub_hash["popup_message"] = upgrade_popup_data.main_msg.blank?? "Update the app to get new features." : upgrade_popup_data.main_msg
        response_hash["upgrade_popup_data"] = sub_hash
      else
        response_hash["upgrade_popup_test_id"] = 0
      end

      #add usability test data to response hash
      if !usability_test_data.blank?
        usability_test_arr = []

        usability_test_data.each{|ut|
          sub_hash = {}
          sub_hash["test_id"] = ut.id
          sub_hash["test_name"] = ut.name
          sub_hash["percentage"] = ut.percentage
          sub_hash["activity_name"] = ut.activity.blank?? " " : ut.activity
          sub_hash["version_codes"] = ut.app_version_code.blank?? " " : ut.app_version_code
         	sub_hash["internet_connection_type"] = ut.internet_connection_type.blank?? " " : ut.internet_connection_type
          sub_hash["positive_btn_text"] = ut.first_button_title.blank?? "Take Survey" : ut.first_button_title
         	sub_hash["negative_btn_text"] = ut.second_button_title.blank?? "Not Now" : ut.second_button_title
         	sub_hash["popup_title"] = ut.header.blank?? "Take our Survey" : ut.header
         	sub_hash["popup_message"] = ut.main_msg.blank?? "Please take short two minute survey." : ut.main_msg

          usability_test_arr << sub_hash
        }

        response_hash["usability_test_data"] = usability_test_arr
        response_hash["is_usability_test_created"] = "true"
      else
        response_hash["is_usability_test_created"] = "false"
      end

      response_hash["status"] = "success"
    rescue Exception => e
      response_hash = Hash.new()
      response_hash["status"] = "error"
      logger.error "ERROR >> #{e}"
    end

    logger.error "RESPONSE HASH >> #{response_hash.inspect}"

    # send a response message
    respond_to do |format|
      format.json{render :json => response_hash.to_json, :callback => params[:callback]}
    end
  end
=end


  private
  def add_uuid_to_db(response, app)

    #   logger.error "add_uuid_to_db -> response -> #{response.inspect}"

    #     raise "params for uuid info not sent" if response["logs_payloads"]["params"].blank?
    user_mobile_info = response["logs_payload"]["params"]

    #    logger.error "add_uuid_to_db -> user_mobile_info -> #{user_mobile_info.inspect}"

    @uuid=MobileUuid.where("uuid='#{user_mobile_info["android_device_id"]}'").first
    if @uuid.blank?
      @uuid=MobileUuid.create(:uuid => user_mobile_info["android_device_id"], :operating_system => user_mobile_info["operating_sys"], :height => user_mobile_info["height"],
        :width => user_mobile_info["width"], :version => user_mobile_info["os_version"], :manufacturer => user_mobile_info["manufacturer"],
        :model => user_mobile_info["model"],:gcm_registration_id=>user_mobile_info["gcm_registration_id"],:lat=>user_mobile_info["lat"],:long=>user_mobile_info["long"],:country=>user_mobile_info["country"])
      raise "mobile info not stored properly" if @uuid.blank?
    else
      @uuid.update_attributes(:gcm_registration_id=>user_mobile_info["gcm_registration_id"].to_s)
    end

    # make a record in app_uuid_map to keep a track of all user records
    # create is in begin rescue block so that any error can be caught due to uniqueness constraint
    _aum = MobileAppUuidMap.find_by_mobile_uuid_id_and_mobile_app_id(@uuid.id, app.id)
    if _aum.blank?
      begin
        MobileAppUuidMap.create(:mobile_uuid_id => @uuid.id, :mobile_app_id => app.id,:last_seen_at=>Time.now)
      rescue Exception => e
        logger.error "add_uuid_to_db -> #{e.to_s}"
      end
    else
		_aum.update_attributes(:last_seen_at=>Time.now)
    end

  end

  private
  def process_incoming(params)
    #	logger.error ">>>>>in process_incoming>>>#{params.inspect}"


    raise "No params sent" if params.blank?
    response = Hash.new()

    raise "JsonObject not received by server" if !params.key?('JsonObject')
    response = JSON.parse(params["JsonObject"])


    raise "Invalid JSON sent" if response.blank? || !response.key?('api_key')

    app_id  = response["api_key"]
    #app_id = params[:api_key]
    raise "No App Key found" if app_id.blank?

    app = MobileApp.find_by_key(app_id)
    raise "No App found for given App Key" if app.blank?
    user = User.find_by_id(app.user_id)
    raise "No user found for given app" if user.blank?
    raise "App doesn't belong to a known user" if app.user_id.blank? || app.user_id==0
    user = User.find_by_id(app.user_id)

    raise "App doesn't belong to a known user" if user.blank?

    #TODO: Payment related stuff to be handled later
    #exp = is_account_expired(user)
    #raise "No further data collection as account has expired" if exp==1
    return response, app

  end

  def set_access_header
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
end
