class Website
	include Mongoid::Document
	include Mongoid::Timestamps
	has_many :web_campaigns
	belongs_to :users
	#attr_protected :id
  	field :name, type: String
  	field :user_id, type: BigDecimal
  	field :is_active, type: Boolean, default: 1
  	field :key, type: String
  	field :domain, type: String

  	default_scope -> {where(is_active: true)}
end