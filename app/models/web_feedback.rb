class WebFeedback 
	include Mongoid::Document
	include Mongoid::Timestamps

	field :user_id, type: BigDecimal
	field :is_active, type: Boolean, default: 1
	field :css, type: String
	field :image_link, type: String
	field :content, type: String
	field :asset_id, type: BigDecimal
	field :web_campaign_id, type: BigDecimal
	field :tab_text, type: String
	field :text_color, type: String
	field :background_color, type: String
	field :border_color, type: String
	field :show_credits, type: Integer
	field :tab_text_drop_shadow, type: Integer
	field :tab_alignment, type: Integer
	field :open_on_click_of_element, type: Integer
	field :open_on_click_of_element_name, type: String
	field :thank_you_message, type: String
	field :routing, type: String
	field :get_name, type: Integer
	field :get_mobile, type: Integer
	field :get_category, type: Integer
	field :get_message, type: Integer
	field :get_rating, type: Integer
	field :get_screenshot, type: Integer
	field :form_title, type: String
	field :title_background_color, type: String
	field :title_text_color, type: String
	field :form_border_color, type: String
	field :form_background_color, type: String
	field :form_text_color, type: String
	field :action_background_color, type: String
	field :action_text_color, type: String
	field :send_to_email, type: String
	field :screenshot, type: String
	field :filters, type: String

	default_scope -> {where(is_active: true)}
	#  has_many :fb_analytics
    belongs_to :web_campaign
  	#serialize :international_params
  	#  acts_as_polymorphic_paperclip
	#attr_protected :id
  	validates_uniqueness_of :web_campaign_id

end

