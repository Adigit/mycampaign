class MobileFeedback
	include Mongoid::Document
  belongs_to :mobile_campaign
#attr_protected :id
  validates_uniqueness_of :mobile_campaign_id

end

