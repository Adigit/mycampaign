class MobileCoupon 
	include Mongoid::Document
  belongs_to :mobile_campaign
  #serialize :international_params
  #acts_as_polymorphic_paperclip
	#attr_protected :id
  validates_uniqueness_of :mobile_campaign_id

end
