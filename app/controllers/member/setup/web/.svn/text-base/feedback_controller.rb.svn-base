class Member::Setup::Web::FeedbackController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def edit
    @campaign = WebFeedback.find_by_id(params[:id])
    @web_campaign = WebCampaign.find_by_model_name_and_model_id(@campaign.class.to_s,params[:id])
    logger.debug "In Setup::Web::FeedbackController > edit > @web_campaign = #{@web_campaign.inspect} and @campaign = #{@campaign.inspect}"

    # in case it was just deactivated, this will reactivate the campaign - Rajat
    #commented it as we want to start campaign only when user click on launch campaign btn - Aashish
    #if @campaign.is_active != 1
     # @campaign.update_attribute("is_active", 1)
    #end

    if @web_campaign.is_active != 1
      @web_campaign.update_attribute("is_active", 1)
    end
    _website = Website.find_by_id(@web_campaign.website_id)
    @web_campaign_filters = WebCampaignFilter.where("website_id in (0,#{_website.id}) and is_active=1")
    @web_campaign_categories = WebCampaignFilter.select("DISTINCT category").where("website_id in (0,#{_website.id}) and is_active=1")
    @countries = Country.all.order('name')

    render :partial => "edit",:locals=>{:domain=>_website.domain}
  end

  def create_or_update
    response_data = {}
    #    begin
    raise "Campaign details not sent" if params[:campaign].blank?

    # create a record
    if params[:campaign][:id].blank?
      @campaign = WebFeedback.create(params[:campaign])
    else
      @campaign = WebFeedback.find_by_id(params[:campaign][:id])
      if !@campaign.blank?
        params[:campaign].delete('id')
        params[:campaign]["is_active"] = 1
        @campaign.update_attributes(params[:campaign])
      end
    end
    @campaign.filters = params[:filters] if !params[:filters].blank?
    @campaign.save
    response_data["status"] = "Success"
    response_data["url"] = "#{SITE_URL}/web/feedback?id=#{@campaign.web_campaign_id}"

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

      campaign = WebFeedback.find_by_id(params[:id])
      if !campaign.blank?
        campaign.update_attribute("is_active", 0)
        campaign.web_campaign.update_attribute("is_active", 0)
      end

      response_data = "Deactivated"
    rescue Exception => e
      response_data = e.to_s
    end
    render :text => response_data
  end

end
