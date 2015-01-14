class WebCoupon 
	include Mongoid::Document
#  has_many :fb_analytics
  belongs_to :web_campaign
  #serialize :international_params
#  acts_as_polymorphic_paperclip
  #attr_protected :id
  validates_uniqueness_of :web_campaign_id

end
