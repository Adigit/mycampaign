class Member::Setup::Mobile::NotificationController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def edit
    @campaign = MobileNotification.find_by_id(params[:id])
    @mobile_campaign = MobileCampaign.find_by_model_name_and_model_id(@campaign.class.to_s,params[:id])

    # in case it was just deactivated, this will reactivate the campaign
    if @campaign.is_active != 1
      @campaign.update_attribute("is_active", 1)
    end

    if @mobile_campaign.is_active != 1
      @mobile_campaign.update_attribute("is_active", 1)
    end
	
	@web_campaign_filters = MobileCampaignFilter.find(:all,:conditions=>"is_active=1")
    @web_campaign_categories = MobileCampaignFilter.find(:all,:select=>"DISTINCT category",:conditions=>"is_active=1")
    @countries = Country.find(:all,:order=>"name ASC")
    
    render :partial => "edit"
  end

  def create_or_update
    response_data = {}
    #    begin
    raise "Campaign details not sent" if params[:campaign].blank?
	logger.error ">>>>>>>>>>>>> campaign_data >>> #{params[:campaign].inspect}"
    # create a record
    if params[:campaign][:id].blank?
      logger.error ">>>>>>> if params[:campaign][:id].blank?"
      @campaign = MobileNotification.create(params[:campaign])
      logger.error ">>>>>>> @campaign >>> #{@campaign.inspect}"
    else
		logger.error ">>>>> else >>>> "
      @campaign = MobileNotification.find_by_id(params[:campaign][:id])
      if !@campaign.blank?
	logger.error " >>>>>>> if !@campaign.blank? >>>>> "
        params[:campaign].delete('id')
        params[:campaign]["is_active"] = 1
        @campaign.update_attributes(params[:campaign])
			@campaign.filters = params[:filters]
         @campaign.save
	logger.error ">>>>>>>> @campaign >>>>>>>> #{@campaign.inspect}"
      end
    end

    response_data["status"] = "Success"
    response_data["url"] = "#{SITE_URL}/mobile/notification?id=#{@campaign.mobile_campaign_id}"

    #    rescue Exception => e
    #      response_data["status"] = "Error"
    #      response_data["message"] = e.to_s
    #    end
    render :json => response_data.to_json, :callback => params[:callback]
  end


  def delete
    response_data = {}

    begin
      raise "Campaign details not sent" if params[:id].blank?

      campaign = MobileNotification.find_by_id(params[:id])
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

end
