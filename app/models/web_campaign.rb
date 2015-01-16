class WebCampaign
  include Mongoid::Document
  include Mongoid::Timestamps
  
  has_many :web_coupons
  has_many :web_feedbacks
  has_many :web_notifications
  
  belongs_to :user
  belongs_to :model
  belongs_to :website

  field :user_id, type: BigDecimal
  field :model_id, type: BigDecimal
  field :campaign_model_name, type: String
  field :website_id, type: BigDecimal
  field :is_active, type: Boolean, default: 1
  field :views, type: Integer
  field :leads, type: Integer
  field :clicks, type: Integer
  field :campaign_data_updated_at, type: DateTime
  field :impressions, type: Integer
  field :last_updated_at, type: DateTime
  field :title, type: String
  #attr_accessible :created_at, :updated_at, :user_id, :model_id, :model_name, :website_id, :is_active, :views, :leads, :clicks, :campaign_data_updated_at, :impressions, :last_updated_at, :title
  def campaign_status
    if is_active == 1
      return "Active"
    else
      return "Expired"
    end
  end

end
