class Mobile::CouponController < ApplicationController


  def index
	
#	response_hash = {}

	 if !params[:id].blank?
		record_web_impression(params[:id])
      @campaign = MobileCoupon.find_by_mobile_campaign_id(params[:id])

      if !@campaign.blank?
        mobile_campaign =  MobileCampaign.find_by_id(params[:id])
        @form_fields, @radio_opt = compute_fields_and_options(params,@campaign, mobile_campaign)
#			response_hash["coupon_info"]=@campaign
      end
    else
      flash[:notice] = "This campaign does not exist"
    end
#		logger.error "response hash is >>>>#{response_hash}"
    render :layout => false
=begin
		respond_to do |format|
      format.json {render :json => response_hash.to_json, :callback => params[:callback]}
=end
  end

  def intro

  end

	def record_web_impression(id)
		t = Time.now.to_date.to_s
		d = t.split('-')
		web_impression = Hash.new
		ana = MobileAnalytic.find_all_by_mobile_campaign_id(id)
		if !ana.blank?
			ana = ana.last
			if !ana.web_impressions.blank?
				web_impression = JSON.parse(ana.web_impressions)
				today = web_impression["#{t}"]
				if !today.blank?
					web_impression["#{t}"] = today + 1
				   q = "update mobile_analytics set web_impressions = '#{web_impression.to_json}' where mobile_campaign_id = #{id} and id = #{ana.id}"
				else
					impr_arr = web_impression.sort
					logger.debug ">>>>>> web_impression >>> #{web_impression.inspect}"
					last_date = impr_arr.last
					last_month = last_date[0].split('-')
					if (d[2] != '01' || d[2] != '1') && ( last_month[1] == d[1] )
						web_impression["#{t}"] = 1
						q = "update mobile_analytics set web_impressions = '#{web_impression.to_json}' where mobile_campaign_id = #{id} and id = #{ana.id}"
					else
						web_impression["#{t}"] = 1
						q = "insert into mobile_analytics( created_at, updated_at, mobile_campaign_id, model_id, model_name, web_impressions )  values( now(), now(), #{id}, #{ana.model_id}, '#{ana.model_name}', '#{web_impression.to_json}')"
					end #if (d[2] != '01' && d[2] != '1') && ( last_month[1] == d[1] )
				end #if !today.blank?
			else 
				web_impression["#{t}"] = 1
				q = "update mobile_analytics set web_impressions = '#{web_impression.to_json}' where mobile_campaign_id = #{id} and id = #{ana.id}"
			end # if !ana.web_impressions.blank?
		else
			camp = MobileCampaign.find_by_id(id)
			if !camp.blank?
				web_impression["#{t}"] = 1
				q = "insert into mobile_analytics( created_at, updated_at, mobile_campaign_id, model_id, model_name, web_impressions )  values( now(), now(), #{id}, #{camp.model_id}, '#{camp.model_name}', '#{web_impression.to_json}')"
			end
		end # if !ana.blank?
		MobileAnalytic.connection.execute(q)
	end

end
