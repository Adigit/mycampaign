class MobileCampaign 
	include Mongoid::Document
#attr_protected :id
 def campaign_status
    if is_active == 1
      return "Active"
    else
      return "Expired"
    end
  end

end

