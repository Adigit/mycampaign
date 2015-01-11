class Member::Campaigns::WebController < ApplicationController
skip_before_filter  :verify_authenticity_token

include CommonTool

  def index
    @websites = Website.where(user_id: current_user.id)

    @web_campaigns = WebCampaign.where(user_id: current_user.id)

    @payment_plan = 24 #current_user.get_payment_plan

    # TODO - Setup pricing and do the needful here
    @used_fans = 0
    @no_remaining_fans = 10000
  end

def leads_graph
      mobile_camp = WebCampaign.find_by_id(params[:camp_id])
      @camp_id = params[:camp_id]
      if !mobile_camp.blank?
         model_name = mobile_camp.model_name
         model_id = mobile_camp.model_id
         @export_data = FormFieldEntry.where("campaign_id = #{params[:camp_id]} and model_name = '#{model_name}'")
      end
      render :partial => "leads_graph", :layout => false
end

	def graph
      return if params[:camp_id].blank?
      @camp_id = params[:camp_id]
      camp = WebCampaign.find_by_id(@camp_id)
		if camp.model_name == 'WebNotification'
			partial = 'notification_graph'
		elsif camp.model_name == 'WebCoupon'
			partial = 'coupon_graph'
		else
			partial = 'feedback_graph'
		end
		logger.debug ">>>>>>>>>>>>>>>>>>>>>>>>> partial >>>>>>>>>.. #{partial.inspect}"
      render :partial => partial, :layout => false
	end

	def show
      return if params[:camp_id].blank?
      response = Array.new
      analytic = WebAnalytic.where("web_campaign_id = #{params[:camp_id]}").all
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
            if params[:type] == 'tab_clicks'
               response << [Time.parse(k).to_i*1000, v['tab_clicks']]
            elsif params[:type] == 'clicks'
               response << [Time.parse(k).to_i*1000, v['clicks']]
            elsif params[:type] == 'continue'
               response << [Time.parse(k).to_i*1000, v['continue']]
				elsif params[:type] == "views"
					response << [Time.parse(k).to_i*1000, v['views']]
            end
         end
      end
      render :json => response.to_json, :callback => params[:callback]
      return
   end

  def refresh
    @websites = Website.where("is_active = 1 and user_id = #{current_user.id}").all
    @web_campaigns = WebCampaign.where("is_active = 1 and user_id = #{current_user.id}").all

    partial_name = case params[:id]
    when "tab_1" then "list"
    when "tab_2" then "edit"
    when "tab_3" then "app"
    when "tab_4" then "insight"
	 when "tab_5" then "leads"
    end
    if !partial_name.blank?
      render :partial => "/member/campaigns/web/#{partial_name}"
    end
    return
  end

  def app_create
    response_data = Hash.new()

    params[:campaign][:user_id] = current_user.id
    string="#{current_user.id}"+"#{params[:campaign][:domain]}"
    bytes=Digest::SHA2.digest(string)
    key=Digest.hexencode(bytes).to_i(32).to_s(36)
    params[:campaign][:key] = key

    Website.create(params[:campaign])
    websites = Website.where("is_active = 1 and user_id = #{current_user.id}").all
	 logger.debug ">>>>>>>> websites >>>>> #{websites.inspect}"
    response_data["status"] = "Success"
    response_data["message"] = "Successfully Saved"
    response_data["app_list"] = websites
	
    render :json => response_data, :callback => params[:callback]
  end

  def create
    response_hash = Hash.new()

    begin
      raise "Required parameters not sent" if params[:campaign].blank?
      raise "Campaign Title can not be blank" if params[:campaign][:title].blank?
      raise "Type of Campaign must be selected" if params[:campaign][:model_name].blank?

      campaign = WebCampaign.new(params[:campaign])
      campaign.is_active = 0
      campaign.user_id = current_user.id

      if campaign && campaign.save

        type = ""
        if campaign.model_name=='WebNotification'
          type = save_notification_campaign_web(campaign)
        elsif campaign.model_name=='WebCoupon'
          type = save_coupon_campaign_web(campaign)
        elsif campaign.model_name=='WebFeedback'
          type = save_feedback_campaign_web(campaign)
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

      if campaign.model_name=='WebNotification'
        response_hash["url"] = "#{SITE_URL}/member/setup/web/notification/edit?id=#{type.id}"
      elsif campaign.model_name=='WebCoupon'
        response_hash["url"] = "#{SITE_URL}/member/setup/web/coupon/edit?id=#{type.id}"
      elsif campaign.model_name=='WebFeedback'
        response_hash["url"] = "#{SITE_URL}/member/setup/web/feedback/edit?id=#{type.id}"
      end
    rescue Exception => e
      response_hash["status"] = "Error"
      response_hash["message"] = "We could not create your campaign -> #{e.to_s}"
    end

    logger.debug response_hash.inspect
    render :json => response_hash.to_json, :callback => params[:callback]
    return

  end

  #TODO
  def insight

    render :partial => "/member/campaigns/web/insight"
  end

  
  
end
