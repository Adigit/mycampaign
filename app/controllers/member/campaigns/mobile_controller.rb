class Member::Campaigns::MobileController < ApplicationController

  def index
    @apps = MobileApp.where("is_active = 1 and user_id = #{current_user.id}")

    @mobile_campaigns = MobileCampaign.where("is_active = 1 and user_id = #{current_user.id}")

    @payment_plan = current_user.get_payment_plan

    # TODO - Setup pricing and do the needful here
    @used_fans = 0
    @no_remaining_fans = 10000
  end

	def graph
		return if params[:camp_id].blank?
      @camp_id = params[:camp_id]
		camp = MobileCampaign.where("id=#{@camp_id}")
		if !camp.blank?
			@data = camp.model_name.constantize.where("id=#{camp.model_id}")
			logger.debug ">>>>>>> @data >>> #{@data.inspect}"
		end
      render :partial => "insights_graph", :layout => false
	end

	def leads_graph
	   mobile_camp = MobileCampaign.where("id=#{params[:camp_id]}")	
		@camp_id = params[:camp_id]
		if !mobile_camp.blank?
			model_name = mobile_camp.model_name
			model_id = mobile_camp.model_id
			fields = FormField.where("campaign_id = #{params[:camp_id]} and model_name = '#{model_name}'")
      	if !fields.blank?
         	@field_hash = Hash.new
        		fields.each do |f|
          		@field_hash["#{f.id}"]=  f.field_name 
        		end
      end
	   	export_signup_data = FormFieldEntry.where("campaign_id = #{params[:camp_id]} and model_name = '#{model_name}'")
	      if !export_signup_data.blank?
   	     @export_data = Hash.new
      	  export_signup_data.each do |exp|
           @export_data["#{exp.id}"] = [JSON.parse(exp.entry_data), exp.created_at]
         end
      end			
		render :partial => "leads_graph", :layout => false
	end
end

	def plot_graph
      return if params[:camp_id].blank?
      response = Array.new
      analytic = MobileAnalytic.where("mobile_campaign_id = #{params[:camp_id]}")
      hash = Hash.new
      imp_hash = Hash.new
      if !analytic.blank?
         analytic.each do |ana|
            if !ana.day_wise_metric.blank?
               hash = hash.merge(JSON.parse(ana.day_wise_metric))
            end
         end
      end
      logger.debug ">>> #{analytic.inspect}"
      if !hash.blank?
         hash = hash.sort
         hash.each do |k,v|
            if params[:type] == 'impressions'
               response << [Time.parse(k).to_i*1000, v['impression']]
            elsif params[:type] == 'btn1'
               response << [Time.parse(k).to_i*1000, v['btn1']]
            elsif params[:type] == 'btn2'
               response << [Time.parse(k).to_i*1000, v['btn2']]
            end
         end
      end
      render :json => response.to_json, :callback => params[:callback]
      return
   end

  def refresh
    @apps = MobileApp.where("is_active = 1 and user_id = #{current_user.id}")
    @mobile_campaigns = MobileCampaign.where("is_active = 1 and user_id = #{current_user.id}")

    partial_name = case params[:id]
    when "tab_1" then "list"
    when "tab_2" then "edit"
    when "tab_3" then "app"
    when "tab_4" then "insight"
	 when "tab_5" then "leads"
    end

    if !partial_name.blank?
      render :partial => "/member/campaigns/mobile/#{partial_name}"
    end
    return
  end



  def app_create
    response_data = Hash.new()

    params[:campaign][:user_id] = current_user.id
    string="#{current_user.id}"+"#{params[:campaign][:platform]}#{params[:campaign][:name]}"
    bytes=Digest::SHA2.digest(string)
    key=Digest.hexencode(bytes).to_i(32).to_s(36)
    params[:campaign][:key] = key
    
    MobileApp.create(params[:campaign])
    apps = MobileApp.where("is_active = 1 and user_id = #{current_user.id}")

    response_data["status"] = "Success"
    response_data["message"] = "Successfully Saved"
    response_data["app_list"] = apps

    render :json => response_data.to_json, :callback => params[:callback]
  end

  def create
    response_hash = Hash.new()

    begin
      raise "Required parameters not sent" if params[:campaign].blank?
      raise "Campaign Title can not be blank" if params[:campaign][:title].blank?
      raise "Type of Campaign must be selected" if params[:campaign][:model_name].blank?

      campaign = MobileCampaign.new(params[:campaign])
      campaign.is_active = 1
      campaign.user_id = current_user.id
      
      if campaign && campaign.save

        type = ""
        if campaign.model_name=='MobileNotification'
          type = save_notification_campaign(campaign)
        elsif campaign.model_name=='MobileCoupon'
          type = save_coupon_campaign(campaign)
        elsif campaign.model_name=='MobileFeedback'
          type = save_feedback_campaign(campaign)
			elsif campaign.model_name="MobilePushNotification"
			type=save_push_campaign(campaign)#not implemented method
        end
        logger.error "type -> #{type.inspect}"
        if type && type.save
          campaign.model_id = type.id
          campaign.save
        else
          logger.error type.errors.inspect
          raise type.errors
        end
      end

      response_hash["status"] = "Success"

      if campaign.model_name=='MobileNotification'
        response_hash["url"] = "#{SITE_URL}/member/setup/mobile/notification/edit?id=#{type.id}"
      elsif campaign.model_name=='MobileCoupon'
        response_hash["url"] = "#{SITE_URL}/member/setup/mobile/coupon/edit?id=#{type.id}"
      elsif campaign.model_name=='MobileFeedback'
        response_hash["url"] = "#{SITE_URL}/member/setup/mobile/feedback/edit?id=#{type.id}"
		elsif campaign.model_name=='MobilePushNotification'
			response_hash["url"]="#{SITE_URL}/member/setup/mobile/push/edit?id=#{type.id}"  #Controller not set up
      end
    rescue Exception => e
      response_hash["status"] = "Error"
      response_hash["message"] = "We could not create your campaign -> #{e.to_s}"

      if !campaign.blank? && !campaign.id.blank?
        campaign.update_attribute("is_active", 0)
      end
    end

    logger.debug response_hash.inspect
    render :json => response_hash.to_json, :callback => params[:callback]
    return

  end

  #TODO
  def insight

    render :partial => "/member/campaigns/mobile/insight"
  end

  private
  def save_feedback_campaign(campaign)
    type = campaign.model_name.constantize.new(:mobile_campaign_id => campaign.id,:user_id => current_user.id,
    :header_message => "Survey", :main_message => "Please provide us your valuable inputs. It will just take 1-2 minutes.",
      :first_button_text => "Participate", :second_button_text => "Not Now"
    )
    return type
  end

  private
  def save_notification_campaign(campaign)
    type = campaign.model_name.constantize.new(:is_active => 1, :user_id => current_user.id,
      :mobile_campaign_id => campaign.id,:header_message => "Upgrade to New Version", :main_message => "New Version offers Voice Calls and lot more features",
      :first_button_text => "Upgrade Now", :first_button_link => "http://play.google.com/",:second_button_text => "Not Now"
    )
    return type
  end

  private
  def save_coupon_campaign(campaign)
    type = campaign.model_name.constantize.new(:mobile_campaign_id => campaign.id, 
      :good_until_hour => "11:00 PM", :good_until_timezone => "8.0", :good_until_date => 30.days.from_now,
      :header_message => "20% Off", :main_message => "Get 20% off on all our products. Offer valid till #{30.days.from_now}",
      :first_button_text => "Claim", :second_button_text => "Skip",
      :user_id => current_user.id)
    return type
  end
		

	def save_push_campaign(campaign)
		type = campaign.model_name.constantize.new(:mobile_campaign_id => campaign.id,:user_id => current_user.id,
    :header_message => "Survey", :main_message => "Please provide us your valuable inputs. It will just take 1-2 minutes.",
      :first_button_text => "Participate", :second_button_text => "Not Now"
    )
		return type	
	end
end
