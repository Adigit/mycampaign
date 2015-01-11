class WebCampaign < ActiveRecord::Base
  has_many :web_coupons
  has_many :web_feedbacks
  has_many :web_notifications
  attr_accessible :created_at, :updated_at, :user_id, :model_id, :model_name, :website_id, :is_active, :views, :leads, :clicks, :campaign_data_updated_at, :impressions, :last_updated_at, :title
  def campaign_status
    if is_active == 1
      return "Active"
    else
      return "Expired"
    end
  end

end
