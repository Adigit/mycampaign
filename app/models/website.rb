class Website
	include Mongoid::Document
  has_many :web_campaigns
  #attr_protected :id
end
