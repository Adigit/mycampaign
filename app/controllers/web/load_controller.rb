class Web::LoadController < ApplicationController
  require 'geoip'
  require 'base64'
  include CommonTool
  

  before_filter :set_access_header
  # API to be called by JS on site
  # Sample URL -> http://beta.socialappshq.com:8087/web/load?id=1&key=ay8d3pi1zzpwmjdv5cd7e9usvpgcrdriclxk5126vkurd5wuvqvwwusrfbrc07&domain=www.ama
  def index
    #logger.error("#{request.url}")
    response_hash = Hash.new()
    begin
      if params[:key].blank? || params[:domain].blank? || params[:id].blank?
        raise "Required inputs are not provided"
      end
	
      website = Website.find(params[:id])
      logger.error ">> website >> #{website.inspect}"
      create_or_update_custom_filter(website, params[:custom_data])   if !params[:custom_data].blank?
      logger.error ">> after >> create_or_update_custom_filter "
      if website.blank?
        raise "Invalid JS code as we could not identify the id flag passed to system"
      end

      if website.key != params[:key] #|| website.domain.match?(params[:domain]) #TODO: Domain check disabled for now
        raise "Invalid JS code as we could not identify the API Key && Domain Name passed to system"
      end

      response_hash["website"] = website
      logger.error "pre pageviewedcounter"
      #pageviewedcounter(website) if !params[:user_time].blank?
      logger.error "post pageviewedcounter"
      # get live campaigns
      campaigns = website.web_campaigns
      logger.error ">> campaigns >> #{campaigns.inspect}"
      raise "No live campaigns found" if campaigns.blank?
      validate_filters_flag = 1
      campaigns.each {|c|
        campaign_model_name = c.campaign_model_name
        if !response_hash.key?("#{campaign_model_name}")
          obj = campaign_model_name.constantize.find(c.model_id)
          if !obj.blank?
            logger.error "campaign running with configuration as : #{obj.inspect}"
            if !obj.filters.blank?
              _filters = JSON.parse(obj.filters)
              logger.error "If filters string is not blank"
              if !_filters.blank?
                logger.error "If filters array is not blank"
                validate_filters_flag = validate_filters(_filters)
              end
            end
            if validate_filters_flag == 1
              logger.error "validate_filters_flag >> #{validate_filters_flag}"
              response_hash["#{campaign_model_name}"] = obj
              response_hash["#{campaign_model_name}"]["web_campaign_id"] = obj.web_campaign_id.to_s
              if !response_hash["#{campaign_model_name}"].blank?
                if campaign_model_name == 'WebCoupon'
                  response_hash["coupon_model_id"] = c.model_id
                  #Added by Shubham - To manipulate date&time with timezone
                  campaign_time, is_valid, offset_from_table = timezone_calculation(c.model_id)
                  time_hash = Hash.new
                  time_hash = {"campaign_time"=>campaign_time,"is_valid"=>is_valid,"offset_from_table"=>offset_from_table}
                  response_hash["timeline"] = time_hash
                end
                if campaign_model_name == 'WebNotification' 
                  response_hash["notification_model_id"] = c.model_id
                end
                if campaign_model_name == 'WebFeedback' 
                  response_hash["feedback_model_id"] = c.model_id
                end
              end
            end
          end
        end
      }
      response_hash["status"] = "Success"
      logger.error ">> response_hash >> #{response_hash}"
    rescue Exception => e
      response_hash["status"] = "Error"
      response_hash["message"] = e.to_s
    end
    if !params[:call_from].blank? && params[:call_from] == 'coupon_iframe' && !response_hash["WebCoupon"].blank?
      #logger.error "When call is from coupon iframe"
      @response_hash = response_hash["WebCoupon"]
      @timeline = Hash.new
      @timeline["campaign_time"] = response_hash["timeline"]["campaign_time"]
      @timeline["is_valid"] = response_hash["timeline"]["is_valid"]
      @timeline["offset_from_table"] = response_hash["timeline"]["offset_from_table"]
      @coupon_model_id = response_hash["coupon_model_id"]
      @website = response_hash["website"]
      @top_host = params[:top_host]
      render :layout => false
      return
      #logger.error "In load controller index action > inspecting @website = #{@website.inspect}"
    else
      render :json => response_hash.to_json, :callback => params[:callback]
    end
  end

  #check filters
  def validate_filters(admin_info_arr)
    begin
      #logger.error "In validate_filters, inspecting admin_info_arr  = #{admin_info_arr.inspect}"
      #admin_info_arr = JSON.parse(admin_info_arr)
      user_info_arr = []
      user_info_arr = get_current_data_of_filters(admin_info_arr)
      #logger.error "In validate_filters, inspecting user_info_arr  = #{user_info_arr.inspect}"
      compared_result = 1
      hash = Hash.new()
      hash["January"] = 1
      hash["February"] = 2
      hash["March"] = 3
      hash["April"] = 4
      hash["May"] = 5
      hash["June"] = 6
      hash["July"] = 7
      hash["August"] = 8
      hash["September"] = 9
      hash["October"] = 10
      hash["November"] = 11
      hash["December"] = 12

      #admin_info_arr.each do |filter|
      for i in 0..(admin_info_arr.size - 1)
        qual_is = admin_info_arr[i][1]
        #logger.error "For #{admin_info_arr[i][0]} , admin value = '#{admin_info_arr[i][2]}' and qualifier = '#{admin_info_arr[i][1]}' and user value = #{user_info_arr[i]}"
        if  admin_info_arr[i][0] == 'Day of the month' || admin_info_arr[i][0] == 'Month of the year' || admin_info_arr[i][0] == 'Hour of the day' || admin_info_arr[i][0] == 'Minute of the hour'
          if admin_info_arr[i][0] == 'Month of the year'
            first_value = hash["#{admin_info_arr[i][2][0]}"]
            second_value = hash["#{admin_info_arr[i][2][1]}"]
            user_value = hash["#{user_info_arr[i]}"]
          else
            first_value = admin_info_arr[i][2][0].to_i
            second_value = admin_info_arr[i][2][1].to_i
            user_value = user_info_arr[i].to_i
          end
          #logger.error "first value is = #{first_value} and second value is = #{second_value}"
          if second_value.blank? || first_value == second_value
            if qual_is == 'Is'
              compared_result = (user_value == first_value)?1:0
            elsif qual_is == 'Is not'
              compared_result = (user_value != first_value)?1:0
            end
          else
            if qual_is == 'Is'
              #logger.error " expression : #{user_value} >= #{first_value} && #{user_value} <= #{second_value}"
              compared_result = (user_value >= first_value && second_value >= user_value)?1:0
            elsif qual_is == 'Is not'
              compared_result = (first_value >= user_value || user_value >= second_value)?1:0
            end
            #logger.error "After comaring value got is : #{compared_result}"
          end
        else
          logger.error ">>>>>>>> user info arr >>>> #{user_info_arr[i].inspect}"
          check_type = (user_info_arr[i].is_a? Integer)?1:0
          logger.error ">>>>>>> check type  >>>>> #{check_type.inspect}"
          if check_type == 1
            first_value = user_info_arr[i].to_i
            second_value = admin_info_arr[i][2].to_i
          else
			      first_value = user_info_arr[i]
            second_value = admin_info_arr[i][2]
		      end
          logger.error ">>>>>>> second_value >>> #{second_value.inspect}"
          if qual_is == 'Is'
            #logger.error "'Is qualifier in else block'"
            compared_result = first_value == second_value ? 1 : 0
          elsif qual_is == 'Is not'
            compared_result = first_value != second_value ? 1 : 0
            logger.error "compared result is : #{compared_result}"
          elsif qual_is == 'Starts with'
            compared_result = (first_value.index(second_value) == 0) ? 1 : 0
          elsif qual_is == 'Contains'
            compared_result = (first_value.index(second_value) != nil) ? 1 : 0
          elsif qual_is == 'Not contains'
            compared_result = (first_value.index(second_value) == nil) ? 1 : 0            
          elsif qual_is == "More than"
            compared_result = first_value > second_value ? 1:0
          elsif qual_is == "Less than"
            compared_result = first_value < second_value ? 1:0
          end
	    
        end
        if user_info_arr[i] == "Client-side handling"
          compared_result = 1
        end
        if user_info_arr[i] == "false"
          compared_result = 0
        end
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
    begin
      #logger.error "In get_current_data_of_filters inspecting filters array = #{arr.inspect}"
      dup_arr = []
      j=0
      arr.each do |filter|
        #logger.error "#{j} Filter's name = #{filter[0]}"
        if filter[0] == 'Country'
          dup_arr[j] = get_country_name(request.remote_ip)
        elsif filter[0] == 'Browser'
          dup_arr[j] = params[:browser]
        elsif filter[0] == 'Operating System'
          dup_arr[j] = get_operating_system()
        elsif filter[0] == 'IP'
          dup_arr[j] = request.remote_ip
        elsif filter[0] == 'Device'
          if is_mobile()
            dup_arr[j] = "Mobile Phones"
          else
            dup_arr[j] = "Desktop"
          end
        elsif filter[0] == 'Referring URL'
          dup_arr[j] = params[:referring_url]
        elsif filter[0] == 'Current URL'
          dup_arr[j] = params[:current_path]
        elsif filter[0] == 'Day of the month'
          dup_arr[j] = params[:user_time].split(" ")[2]
        elsif filter[0] == 'Month of the year'
          dup_arr[j] = params[:user_time].split(" ")[1]
        elsif filter[0] == 'Hour of the day'
          dup_arr[j] = params[:user_time].split(" ")[4].split(":")[0]
        elsif filter[0] == 'Minute of the hour' 
          dup_arr[j] = params[:user_time].split(" ")[4].split(":")[1]
          ##Changes done today - 31 may
        elsif filter[0] = 'Number of visits to my site' || filter[0] = 'Number of days since last visit' || filter[0]='Number of pages viewed this visit' || filter[0] = 'Seconds spent on current page' || filter[0] ='Seconds spent on this visit'
          dup_arr[j] = "Client-side handling"
        else
          dup_arr[j] = "false"
          logger.error "For custom filter 0"
          if !params[:custom_data].blank? && !JSON.parse(params[:custom_data]).blank?
            logger.error "For custom filter 1"
            custom_data = JSON.parse(params[:custom_data])
            logger.error "For custom filter 2"
            dup_arr[j] = custom_data["#{filter[0]}"][0] if !custom_data["#{filter[0]}"].blank? && !custom_data["#{filter[0]}"][0].blank?
            logger.error ">>>>>>>>> custom_data >>>> #{custom_data.inspect} >>> filter >>>> #{filter[0].inspect}"
            logger.error "For custom filter -> value is #{dup_arr[j]}"
          end
			 	
        end
        j += 1
      end
    rescue Exception => e
      logger.error "Exception error caught in get_current_data_of_filters function is : #{e.to_s}"
    end
    return dup_arr
  end

  def get_country_name(ip_addr)
    begin
      geoip = GeoIP.new("/var/www/usersdelight/public/GeoLiteCity.dat")
      data = geoip.city(ip_addr)
      #logger.error "country_name => #{data.country_name} for ip address => #{ip_addr}"
      return data.country_name
    rescue Exception => e
      logger.error "Exception caught while fetching county name of user in load cotroller."
    end
  end

  def get_operating_system
    if request.env['HTTP_USER_AGENT'].downcase.match(/mac/i)
      "Mac"
    elsif request.env['HTTP_USER_AGENT'].downcase.match(/windows/i)
      "Windows"
    elsif request.env['HTTP_USER_AGENT'].downcase.match(/linux/i)
      "Linux"
    elsif request.env['HTTP_USER_AGENT'].downcase.match(/unix/i)
      "Unix"
    else
      "Unknown"
    end
  end

  #Saving email in db
  def save_email_in_db
    response = Hash.new
    begin
      _form_field_entry = FormFieldEntry.new
      _form_field_entry.model_id = params["model_id"]
      _form_field_entry.model_name = params["model_name"]
      _form_field_entry.campaign_id = params["campaign_id"]
      _form_field_entry.email = params["email"]
      _data = Hash.new
      _data["site_path"] = params["site_loc"] if !params["site_loc"].blank?
      _form_field_entry.entry_data = _data.to_json if !_data.blank?
      _form_field_entry.created_at = Time.now
      _form_field_entry.updated_at = Time.now
      _form_field_entry.form_field_id = -1
      _form_field_entry.save
      response["status"] = "saved"
    rescue Exception => e
      response["status"] = "error"
      logger.error "Error while saving Email in DB = #{e.to_s}"
    end
    render :json => response.to_json,:callback => params[:callback]
  end

  #saving feedback data in db
  def save_feedback_in_db
    begin
      response = Hash.new
      _form_field_entry = FormFieldEntry.new
      _form_field_entry.form_field_id = -1
      _data = Hash.new
      _data["name"] = params[:first_name] if !params[:first_name].blank? 
      _data["email"] = params[:email] if !params[:email].blank? 
      _data["mob_num"] = params[:mob_num] if !params[:mob_num].blank? 
      _data["category"] = params[:category] if !params[:category].blank? 
      _data["rating"] = params[:rating] if !params[:rating].blank? 
      _data["message"] = params[:message] if !params[:message].blank? 
      _browser_data = Hash.new
      _browser_data["browser_name"] = params[:browser_name]
      _browser_data["full_version"] = params[:full_version]
      _browser_data["major_version"] = params[:major_version]
      _browser_data["app_name"] = params[:app_name]
      _browser_data["user_agent"] = params[:user_agent]
      _browser_data["call_from_path"] = params[:call_from_path]
      _data["browser_data"] = _browser_data
      _form_field_entry.campaign_model_name = params[:model_name]
      _form_field_entry.model_id = params[:model_id]
      _form_field_entry.email = params[:email]
      _form_field_entry.campaign_id = params[:campaign_id].to_s
      _form_field_entry.entry_data = _data
      _form_field_entry.img_data = params[:image_content] if !params[:image_content].blank?
      _form_field_entry.save
      response["status"] = "saved"
    rescue Exception => e
      puts "Exception caught in saving the form = #{e.to_s}"
      response["status"] = "error"
    end
    render :json => response.to_json,:callback => params[:callback]
  end

  # Added by Shubham Gulati to send Screenshot link with email
  def send_image_url
    _form_field_entry = FormFieldEntry.find(params[:id])
    _entry_data = _form_field_entry.img_data
    @data_img_src = _entry_data
    render :template => 'web/load/send_image_url', :layout => false
  end

  #timezone calculation - by Shubham Gulati
  def timezone_calculation(_id)
    if !_id.blank?
      @time_data = WebCoupon.find(_id)
      #  flash[:notice] = "This coupon does not exist"
    end
    if !@time_data.good_until_date.blank? && !@time_data.good_until_hour.blank? && !@time_data.good_until_timezone.blank?
      valid_till_date = @time_data.good_until_date
      valid_till_hour= @time_data.good_until_hour
      offset_from_table = @time_data.good_until_timezone
      if valid_till_hour.include?('PM')
        campaign_time = valid_till_hour.to_i*60 + 12*60
      else
        campaign_time = valid_till_hour.to_i*60
      end
   
      if !valid_till_date.blank?
        campaign_time = valid_till_date.to_time.to_i + campaign_time*60
      end

      time1 = Time.now.to_i

      is_valid = 0
      #now check whether coupon expiry time and current time and invalidate coupon accordingly
      diff = campaign_time - time1
      if(diff > 0)
        is_valid = 1
      else
        status = "Coupon has been Expired"
      end
      time_calculated = campaign_time
    end
    return time_calculated, is_valid, offset_from_table
  end

  def record_analytics
    #record_web_analytics(params)
    render :text => "1"
    return
  end

  private
  def pageviewedcounter(website)
    #LocalCache.set("pagesviewedpermonth",Hash.new)
    #LocalCache.set("pages_viewed_counter",0)
    current_time = params["user_time"]
    current_month = params["user_time"].split(" ")[1]
    current_year = params["user_time"].split(" ")[3]
    key = "#{website.id}_#{website.user_id}_#{current_month}_#{current_year}"
    #logger.error "Key formed for current stats = #{key}"
    _page_views_cache = LocalCache.get("pagesviewedpermonth")
    #logger.error "page views cache result = #{_page_views_cache}"
    #logger.error "Going in loop condition"
    if !_page_views_cache.blank? && !_page_views_cache[key].blank?
      #logger.error "If page views cache with specific key found"
      #logger.error "Setting local cache value after incrementing the value"
      hash = _page_views_cache
      value = hash[key]
      hash[key] = value + 1
      #logger.error "Hash formed is :- #{hash.inspect}"
      LocalCache.set("pagesviewedpermonth",hash)
    else
      #logger.error "setting cache with starting"
      hash = _page_views_cache
      hash[key] = 1
      #logger.error "Hash formed is :- #{hash.inspect}"
      LocalCache.set("pagesviewedpermonth",hash)
      #logger.error "cache results after setting = #{LocalCache.get("pagesviewedpermonth")}"
    end
    count = LocalCache.get("pages_viewed_counter")
    #logger.error "count is = #{count}"
    count = !count.blank? ? (count + 1) : 1
    LocalCache.set("pages_viewed_counter", count)
    if !count.blank? && count > 5
      _page_views_cache = LocalCache.get("pagesviewedpermonth")
      #logger.error "If count is exceeding 1"
      LocalCache.set("pagesviewedpermonth",Hash.new)
      LocalCache.set("pages_viewed_counter",0)
      flush_page_views_analytics_to_db(_page_views_cache)
    end
    return
  end

  private
  def flush_page_views_analytics_to_db(page_views)
    #logger.error "Flushing values in db"
    page_views.each do |k,v|
      _website_id = k.split("_")[0]
      _user_id = k.split("_")[1]
      _month = k.split("_")[2]
      _year = k.split("_")[3]
      #logger.error "For key = #{k} with value =#{v}"
      _user_monthly_views = UserMonthlyView.where("website_id =#{_website_id} and month = '#{_month}' and year = #{_year}").first
      #logger.error "user monthly views -> #{_user_monthly_views.inspect}"
      if !_user_monthly_views.blank?
        _views =  _user_monthly_views.views + v
        _user_monthly_views.views = _views
        _user_monthly_views.save
      else
        _user_monthly_views = UserMonthlyView.new
        _user_monthly_views.user_id = _user_id
        _user_monthly_views.website_id = _website_id
        _user_monthly_views.month = _month
        _user_monthly_views.year = _year
        _user_monthly_views.views = v
        _user_monthly_views.save!
        #logger.error "user monthly views -> #{_user_monthly_views}"
      end
    end
    return
  end

	private 
	def create_or_update_custom_filter(website, custom_data)
		logger.debug ">>> custom data >>> #{custom_data} >>>> #{params[:custom_data].to_json} >>>>>> create or update function"
    custom_data = JSON.parse(custom_data)
    custom_data.each do |k,v|
      logger.debug ">>>>>> k >> #{k} >>> v >>> #{v[0]}"
      wcf = WebCampaignFilter.find_by website_id: website.id, category: 'Custom', filter: k
      logger.debug ">>>>>>> wcf >>>> #{wcf.inspect}"
      if wcf
        filters = wcf.qual_input
        logger.debug ">>>>>>>> filters >>>>> #{filters}"
        #filter = filters[1]
        logger.debug ">>>>>>>> filters >>>>> #{filters}"
        if !(filters[1].include?(v[0]))
          logger.debug ">>>>> inside if >>>>>>> "
          filters[1] << v[0]
          logger.debug ">>>>>> #{filters}"
          wcf.update_column(:qual_input, filters)
        end
      else
        if v[0].is_a?(Integer)
          WebCampaignFilter.create(category: 'Custom', filter: k, qual_input: [['Is', 'Is not','More than','Less than'],v], is_active: 1, website_id: website.id)
        else
          WebCampaignFilter.create(category: 'Custom', filter: k, qual_input: [['Is', 'Is not'],v], is_active: 1, website_id: website.id)
        end
      end
    end
  end

  def set_access_header
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
end
