class Mobile::RecordController < ApplicationController
  require 'json'
  KEY = "mobilenalyt"
  COUNT = "count"
	def analytic
	 response_hash = {}
    popup_metrics = {}
	 date = Time.now.to_date.to_s
	 d = date.split('-')
	 analytics = LocalCache.get(KEY)
	 logger.debug ">>>>>>>> analytics >>>>> #{analytics.inspect}"
	 count = LocalCache.get(COUNT)
	 count = !count.blank? ? (count + 1) : 1
	 LocalCache.set(COUNT, count)
    popup_metrics = JSON.parse(params[:analytic_json])	
	 if !popup_metrics.blank?
	 	 app_key = popup_metrics["app_key"]
		 if !app_key.blank?
		    app = MobileApp.find_by_key(app_key)
			 if !app.blank?
				 camp_data = popup_metrics["campaigns"]
				 if !camp_data.blank?
					 camp_data.each do |k,v|
						 camp_details = MobileCampaign.find_by_id(k)
						 if !camp_details.blank?
							 model_id = camp_details.model_id
							 model_name = camp_details.model_name
							 key = "#{k}_#{model_name}_#{model_id}"
							 if !analytics.blank? && !analytics[key].blank? && !analytics[key][date].blank?
								analytics[key][date]["impression"] += v["total_impression"]
								analytics[key][date]["btn1"] += v["positive_impression"]
								analytics[key][date]["btn2"] += v["negative_impression"]
								logger.debug ">>>> update analytic >>> #{analytics.inspect}"
							 else
								if !analytics.blank? && analytics.length > 0
									LocalCache.delete(KEY)
									LocalCache.delete(COUNT)
									logger.debug ">>>>>>>> flush >>>>>>"
									flush_to_db_mobile_analytics(analytics)
									count = 0
								end
									analytics = {} if analytics.blank?
									analytics[key] = {"#{date}" => { "impression" => v["total_impression"], "btn1" => v["positive_impression"], "btn2" => v["negative_impression"] } }
							 end # if !analytics.blank? && !analytics[key].blank? && !analytics[key][date].blank?
							LocalCache.set(KEY, analytics)
							if !count.blank? && count > 0 
						      LocalCache.delete(KEY)
						      LocalCache.delete(COUNT)
								logger.debug ">>>>>> flush >> limit >>> "
						      flush_to_db_mobile_analytics(analytics)
						      count = 0
						   end
						 end	#if !camp_details.blank?
					 end #camp_data.each do |k,v|
				 end #if !camp_data.blank?
			 end #if !app.blank?
		 end #if !app_key.blank?
	 end #if !popup_metrics.blank?
			begin
      response_hash["status"] = "success"
		rescue Exception => e
			logger.error "ERROR WHILE CREATING NEW RECORD FOR UpgradePopupsPoint -> #{e.to_s}"
			response_hash["status"] = "failure"
		end
	
    respond_to do |format|
      format.json{render :json => response_hash.to_json, :callback => params[:callback]}
    end
	end

  private
 
	def flush_to_db_mobile_analytics(analytics) 
		analytics.each do |k,v|
         campaign_id = k.split('_')[0]
         model_name = k.split('_')[1]
         model_id = k.split('_')[2]
         # Do not bother for loop, it runs only once. So code followes waterfall flow.
         v.each do |date, analytic|
            logger.debug ">>>> date, >>>> #{date.inspect} >>> analytics >>> #{analytics.inspect}"
				impression = analytic["impression"].to_i
				click = analytic["btn1"].to_i + analytic["btn2"].to_i
            month = date.split("-")[1].to_i
            year = date.split("-")[0].to_i
            record_exist = MobileAnalytic.find_by_model_id_and_model_name_and_mobile_campaign_id_and_month_and_year(model_id, model_name, campaign_id, month, year)
            if record_exist.blank?
               h = Hash.new
               h[date] = analytic
               MobileAnalytic.connection.execute("insert into mobile_analytics(created_at, updated_at, mobile_campaign_id, model_name, model_id, day_wise_metric, month, year) values(now(), now(), #{campaign_id}, '#{model_name}', #{model_id}, '#{h.to_json}', #{month}, #{year})")
            else
               metric = JSON.parse(record_exist.day_wise_metric)
					if !metric[date].blank?
						logger.debug ">>>>>>>>> update analytic >>>>> #{metric[date].inspect}"
						temp = {"impression" => analytic["impression"] + metric[date]["impression"], "btn1" => analytic["btn1"] + metric[date]["btn1"], "btn2" => analytic["btn2"] + metric[date]["btn2"]}
						logger.debug ">>>>>>>> #{temp.inspect}"
         	      metric[date] = temp
					else
						metric[date]= analytic 
					end
               MobileAnalytic.connection.execute("update mobile_analytics set updated_at = now(), day_wise_metric = '#{metric.to_json}' where id = #{record_exist.id}")
            end
            MobileCampaign.connection.execute("update mobile_campaigns set updated_at = now(), impressions = impressions + #{impression} , clicks = clicks + #{click} where id = #{campaign_id}")
         end
      end

	end

  def process_incoming(params)

    raise "No params sent" if params.blank?
    response = Hash.new()

    raise "JsonObject not received by server" if !params.key?('JsonObject')
    response = JSON.parse(params["JsonObject"])


    raise "Invalid JSON sent" if response.blank? || !response.key?('api_key')

    app_id  = response["api_key"]
    raise "No App Key found" if app_id.blank?

    app = App.find_by_key(app_id)
    raise "No App found for given App Key" if app.blank?
    user = User.find_by_id(app.user_id)
    raise "No user found for given app" if user.blank?
    raise "App doesn't belong to a known user" if app.user_id.blank? || app.user_id==0
    user = User.find_by_id(app.user_id)

    raise "App doesn't belong to a known user" if user.blank?
    exp = is_account_expired(user)
    raise "No further data collection as account has expired" if exp==1
    return response, app

  end
	
	def update_analytic(camp_details, ana, t, d, impression, btn1_clicks, btn2_clicks)
		begin
		metric = Hash.new
		if !ana.blank?
      	ana = ana.last
         metric = JSON.parse(ana.day_wise_metric)
         if !metric.blank?
         	today = metric["#{t}"]
            	if !today.blank?
               	impression += today["impression"]
                  btn1_clicks += today["btn1"]
                  btn2_clicks += today["btn2"]
                  metric["#{t}"] = {"impression" => impression, "btn1" => btn1_clicks, "btn2" => btn2_clicks}
						# update record 	
						q = "update mobile_analytics set day_wise_metric = '#{metric.to_json}' where model_name = '#{ana.model_name}' and model_id = #{ana.model_id} and id = #{ana.id}"
               else
               	temp = metric.sort
                  last_date = temp.last
                  last_month = last_date[0].split('-')
                  metric["#{t}"] = {"impression" => impression, "btn1" => btn1_clicks, "btn2" => btn2_clicks}
                  if (d[2] != '01' || d[2] != '1') && ( last_month[1] == d[1] )
                  	# update record insert
							q = "update mobile_analytics set day_wise_metric = '#{metric.to_json}' where model_name = '#{ana.model_name}' and model_id = #{ana.model_id} and id = #{ana.id}"
                  else
                    # new record insert
							q = "insert into mobile_analytics( created_at, updated_at, mobile_campaign_id, model_id, model_name, day_wise_metric ) values( now(), now(), #{ana.mobile_campaign_id}, #{ana.model_id}, '#{ana.model_name}', '#{metric.to_json}')"
                  end
             	end #if !today.blank?
          end #if !metric.blank?
      else
			logger.error "In Mobile::RecordController update_analytic start metric blank"
      	metric["#{t}"] = {"impression" => impression, "btn1" => btn1_clicks, "btn2" => btn2_clicks}
         # new record 
			logger.debug ">>>> ana blank >>>"
			q = "insert into mobile_analytics( created_at, updated_at, mobile_campaign_id, model_id, model_name, day_wise_metric ) values( now(), now(), #{camp_details.id}, #{camp_details.model_id}, '#{camp_details.model_name}', '#{metric.to_json}')"
      end #if !ana.blank?
		MobileAnalytic.connection.execute(q)
		camp_details.update_attributes(:impressions => impression, :clicks => btn1_clicks + btn2_clicks)
	rescue Exception => e
	end
end
end
